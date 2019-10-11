Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B876C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF5E218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YDg7jd9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfJKXwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 19:52:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35835 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfJKXwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:52:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15so16367663qtq.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 16:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=MISH1PDZt9MNvLY625jcYTV0a+n6dTpjlTuxG4RxgbM=;
        b=YDg7jd9ZqdXZqMgk//uFIx4+02PLEpPrl8eL3gPiOUzcZZxYVuZ0sm7qMkPPe4TEso
         CzqZ7kRO+Qksj2QubZE4GU+qGA8CSvqn4FNz8zgKT5JjEZd9SBCjawJhDY2BInJk4HGZ
         iYEDgAvUA6aYAVWRT0bwJt/yTdr5ir0WsxBDTmo3T2rzGH9tOugvqVYZQNcjrgPmo9l+
         aFOLMG8Xs6kIn/YMa5dEAjL231Dih8nH55OVXRUs/AWpEFNRQJbiDRORrLurHsz64uSk
         ROghOE+opMX2yMGhUpqIWhYNFb60wxER5MgxkfkJaMP8MwkN0UrgMkqOttFyqcph3U6u
         mVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=MISH1PDZt9MNvLY625jcYTV0a+n6dTpjlTuxG4RxgbM=;
        b=tKtZT8OH94rYGUiUGnrj8J4F7YEvMk9n+0xHbj8kELSebSB3byC6nJVX/0oa++z8j6
         LgvDgKV4ZcI++IpxKwrxe+xCFqNL2tdhovqpfDFKeM1QDR3KPjOEMdveI2hK8nbnwZKw
         O5fGdPPrtcjSbd1RmJ13z3kMFoihfeGXT4Lwc2TMnKz2fNoDJEM3IWeRPzuIndBkfYSv
         QlM5ZxOhA0Y6ibojgwM//Gu66Gw/kYSgWrI9igu0QF9DMFkc0S8pGcJcmuH/+Hl8HYmx
         r5kY4Hbox0AYQfWcn9Ie9nh6nVlq9AsQmUi7qcc0Rh5CyG1T7mEsstT2LA2N8GMSPS5P
         gwfA==
X-Gm-Message-State: APjAAAWjmZdGJmSN18bhfVMqdVRYyN4JHkgPY1Ei/0+PoGQ1QrJ7JK71
        CaO25W1e7/b11uif3z0BG70WcP4LM4T1fg==
X-Google-Smtp-Source: APXvYqwGox9Ul2ppOXU3NBNTbVqsiZNta2iDQ3uguXhrIP6mhjuzSzgKPa7ncU7KJQB2gAplXTNnWw==
X-Received: by 2002:ac8:1991:: with SMTP id u17mr20319338qtj.369.1570837969512;
        Fri, 11 Oct 2019 16:52:49 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u43sm5579373qte.19.2019.10.11.16.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 16:52:49 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages creation
Date:   Fri, 11 Oct 2019 19:52:48 -0400
Message-Id: <4641B95A-6DD8-4E8A-AD53-06E7B72D956C@lca.pw>
References: <CAHD1Q_ynd6f2Jc54k1D9JjmtD6tGhkDcAHRzd5nZt5LUdQTvaw@mail.gmail.com>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
In-Reply-To: <CAHD1Q_ynd6f2Jc54k1D9JjmtD6tGhkDcAHRzd5nZt5LUdQTvaw@mail.gmail.com>
To:     Guilherme Piccoli <gpiccoli@canonical.com>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 11, 2019, at 7:42 PM, Guilherme Piccoli <gpiccoli@canonical.com> wr=
ote:
>=20
> Thanks for the quick response. Kdump in Ubuntu, for example, rely in
> mounting the root filesystem.
> Even in initrd-only approaches, we could have sysctl.conf being copied
> to initramfs, and hugepages end-up getting set.

It simply error-prone to reuse the sysctl.conf from the first kernel, as it c=
ould contains lots of things that will kill kdump kernel.=
