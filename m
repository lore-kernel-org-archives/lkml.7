Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AE9C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E742073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DprpQ0o3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLIQmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:42:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48753 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbfLIQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575909720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IOIs+T0JPjFAhSLIWFD9VPKRUMGW1/PSSpZsJupmtqs=;
        b=DprpQ0o346JRQYdLWSffallMBtaM231p6ge3GrPx+cCa6Bj8GZ560u9NcD2BwessbufJUd
        KlrEr1JYPYYU17IkFGv8rziiVqOk+hary0q5+dZQyXa+skbKgmGTMybA356V1MJQgOimKG
        WHFZuDZDncqI/ehJTrlEalxoKrL/3Ik=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-ozR-9nQwNPK11AmK3iSQFA-1; Mon, 09 Dec 2019 11:41:58 -0500
Received: by mail-yb1-f197.google.com with SMTP id o85so6312968yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 08:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7O3guB7wOY3MrLnldmdm9BIXXTqe2JfD4cDZWNKwU28=;
        b=ZMu0ekQeUSwpgGuMGC8d6eNdN+pylnmktb5/XLgYkx9YH5podqAKnph7nAZgyEnIQ0
         ddFWhzlJJYKTbwPAp1hKDRCi5v6sqNN9GWagzeTxS83QWQTkVgOJqnxsavZA/pT/SsiS
         zjnfT2abHqRz0pfsjZEdffg/uMev9WYGb1hCy1QrCnoMCA7nvy9bAWSzoUFc3hIklzJ0
         6/c3cgAwzi/HTbdYg+IwfMTGvoeXUJhS/Hq7lbl+TsRG78MfdPAty9jlmVMzldwyCz63
         Zq3bY5srOSK76VBB0kNaUpdyegn8UHXPyH+2abp3g0YUcJIxbAKBtK2P9PsBAj29p3KO
         EsyA==
X-Gm-Message-State: APjAAAV9/CUwa75UmnUmo6vb2jo4QaFK8M7GvG8CH/B9WJbSuhZaCaC2
        h8qcgPVoUxVKjIqmo+qH+kX7GPMzWV/TfY5FjjwiKKE77BFJ99GxUY7AdnAgEWgPBn69eOAU1Pn
        FWpCW8fgIU7jxF9Hycd2J7T77
X-Received: by 2002:a81:2781:: with SMTP id n123mr22719234ywn.70.1575909717689;
        Mon, 09 Dec 2019 08:41:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqx/ZUHMqp43x8Abr0QbypV4zplr0Lxd2ECWn2wddcNUn2SzoWt0sz3QIsRsKZxWbketkY9G9w==
X-Received: by 2002:a81:2781:: with SMTP id n123mr22719219ywn.70.1575909717409;
        Mon, 09 Dec 2019 08:41:57 -0800 (PST)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id d186sm144163ywe.0.2019.12.09.08.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 08:41:56 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:41:55 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: s390 depending on cc-options makes it difficult to configure
Message-ID: <20191209164155.GA78160@dev.jcline.org>
MIME-Version: 1.0
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: ozR-9nQwNPK11AmK3iSQFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Commit 5474080a3a0a ("s390/Kconfig: make use of 'depends on cc-option'")
makes it difficult to produce an s390 configuration for Fedora and Red
Hat kernels.

The issue is I have the following configurations:

CONFIG_MARCH_Z13=3Dy
CONFIG_TUNE_Z14=3Dy
# CONFIG_TUNE_DEFAULT is not set

When the configuration is prepared on a non-s390x host without a
compiler with -march=3Dz* it changes CONFIG_TUNE_DEFAULT to y which, as
far as I can tell, leads to a kernel tuned for z13 instead of z14.
Fedora and Red Hat build processes produce complete configurations from
snippets on any available host in the build infrastructure which very
frequently is *not* s390.

I did a quick search and couldn't find any other examples of Kconfigs
depending on march or mtune compiler flags and it seems like it'd
generally problematic for people preparing configurations.

Regards,
Jeremy

