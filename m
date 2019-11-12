Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D15C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 03:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167502084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 03:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3w8q5KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKLDgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 22:36:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32019 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLDgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 22:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573529803;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aCpQt1ZhYboSDvHFUTsiD3XPm9kOvrjtHzxUZdWKqsM=;
        b=J3w8q5KX5NNE0vro3b8LfZheQjghX1v0SxB7qqZrNkHPeX4eOW9sIXqxBcMSSyxifvlA/1
        OyICUTMI2T56DpIjIvnDjdxwMPPbb4WeEyR+gT2VoQ8Dosk0ISWyDowYQjU38TsaARnODK
        7pMCL2s8VvjVuB9HELntzkVpzaZq77g=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-B9DZbdVSMXG5rv-E5SWzBQ-1; Mon, 11 Nov 2019 22:36:41 -0500
Received: by mail-yb1-f200.google.com with SMTP id u10so141037ybm.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 19:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:mime-version:content-disposition;
        bh=/1ARDGGQ15uF46oAOzdoibrj2QJIiMCSuS05wL1ErLI=;
        b=XdLJLQKMBvAHHCjv++WwtmLIT1JnwtCzuncloMMtUMp/xVseObOv9p11NiQFKy6Djr
         Vt4+fcAhVGXhjbnG5zox4lQCBIybhAQ10K6QVH+ihhlLRbtJIVFAkARMa7HTPIwavb6h
         0nZBzGqS++50TsIC+Pk87Mq4pHpowi95BistbIQclNX5vh+5KXDXAFa8JZJc8AC+ApXz
         TR1Lvv4pu4bjtTRg+hJrEis0paHIEdSVQI1ESPs7KUsHJCGZqgOs8/peqczxXSEmIRJK
         SQXxeHodHN9pS4uStSEhTkui9vAydAOtIxi4emH8ErxGvlV10hpLEdVeYJXOuOYSViwt
         jb2A==
X-Gm-Message-State: APjAAAWmJSK3JZNzknUXrOG42LBtfgwa/aBGdh26Gmh5kc2tKCcLOjyr
        xvjPd96MYr/OvTyqShEmZlTzO5F5tDsAriPlKyHPbVbAn0zn452eQX4DHyvjf5Q8p+DeX5kqNZL
        LBgRgjPVhelIdYb+JeUAaBkwF
X-Received: by 2002:a0d:d307:: with SMTP id v7mr18393618ywd.300.1573529800611;
        Mon, 11 Nov 2019 19:36:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnrgVNvPYNQ7lJLTh7ZbIVCVDYyBwENVzJc7NGixTK7eawM2Npsto2yMtqFwJCUQe+vAiNPQ==
X-Received: by 2002:a0d:d307:: with SMTP id v7mr18393605ywd.300.1573529800280;
        Mon, 11 Nov 2019 19:36:40 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x78sm7369131ywg.108.2019.11.11.19.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 19:36:39 -0800 (PST)
Date:   Mon, 11 Nov 2019 20:36:37 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: question about setting TPM_CHIP_FLAG_IRQ in tpm_tis_core_init
Message-ID: <20191112033637.kxotlhm6mtr5irvd@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-MC-Unique: B9DZbdVSMXG5rv-E5SWzBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Question about 1ea32c83c699 ("tpm_tis_core: Set TPM_CHIP_FLAG_IRQ before pr=
obing for interrupts").
Doesn't tpm_tis_send set this flag, and setting it here in tpm_tis_core_ini=
t short circuits what
tpm_tis_send was doing before? There is a bug report of an interrupt storm =
from a tpm on a t490s laptop
with the Fedora 31 kernel (5.3), and I'm wondering if this change could cau=
se that. Before they got
the warning about interrupts not working, and using polling instead.

