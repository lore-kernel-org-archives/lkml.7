Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0989C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEBE20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies-com.20150623.gappssmtp.com header.i=@colorremedies-com.20150623.gappssmtp.com header.b="DZ9BXRRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLKS6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:58:43 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45845 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfLKS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:58:43 -0500
Received: by mail-wr1-f41.google.com with SMTP id j42so25211924wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSKdgdYY5opCbmGfJWr/upIg8QDhnphk02uvpiS8sEc=;
        b=DZ9BXRRJRfbvk+0g+r571hkP4dVp9Y/5lOupvmgxK9V1zXXL8v1pU1uvEugrnAfk0k
         HHd1H5E023KKGYPmCbv/wQLcxDM6uqizq/NiJRokaKX95tlycvIe4ZH6fbaTvofm81z2
         xkNi9jGsPlrMEoaDkqS8Db5LQb9LdgEncRwTZauelLz7hr1YZrQ2qd81YOartceckWBa
         laR5ya2T8ieqi5jtVUe5fkHl3Nzf97jbxmDIW5fnejuwnIXvBijeAVUm1YJxrnT5eaQO
         chjpSRDm2UQkXBiWwgjIyvAqTA08Rrjhrhc085BKtypka7QgXpSJkMXa/PDt9T/xoMNk
         EXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSKdgdYY5opCbmGfJWr/upIg8QDhnphk02uvpiS8sEc=;
        b=aKMTlyvnG3ouhnpwCEp8SL1N5n+fGdHwFIXZ/dth2tZun8KoK1VA33RXCLabB36XsH
         zamNwrqWc5qYz0LHBDhozvelm3hAwJjN0rHG+McoH0T+CiAKqX+K8e38R9R7f/jK8mZg
         jO2bORGgsQTcAjh5HMPmivbBu//LZSH0+VUnyx+snbqMupQEnRd0t9hXbGtPjK9MT3xN
         tZ1RAFR2xbmhIAAVBbczFhRS8fLdL4K9GMuts/9Z0Npwf3cyLb9WsDqhOEiK3kiKGodg
         fC5LnuJTAa7I8AfWjU/yOxtWaEUXRhtP9fZ1sNGE4g4wNRlfbT3Xe8c4/Nejm4de3qDM
         2eDA==
X-Gm-Message-State: APjAAAXdWVrTz6U/pG2PRWLKKR2jo7aqWdDNf6kur74DD2zbtt8wJgpX
        AbkL3LwdWq4LVvqFhJPClFJFoqHYvkFiyt2Wx4EQrA==
X-Google-Smtp-Source: APXvYqzXesre9QX82R9h0bn2mWv3UrDphe0ow57qjCZcpDFAWLnv7xuzpof9Pb0IKCFRQCvZLtQAmVx7Id+TGbhFCGo=
X-Received: by 2002:adf:82f3:: with SMTP id 106mr1441133wrc.69.1576090721341;
 Wed, 11 Dec 2019 10:58:41 -0800 (PST)
MIME-Version: 1.0
References: <9df7f98b-271f-8b1d-f360-00a737d49911@gmx.de>
In-Reply-To: <9df7f98b-271f-8b1d-f360-00a737d49911@gmx.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 11 Dec 2019 11:58:25 -0700
Message-ID: <CAJCQCtSWW4ageK56PdHtSmgrFrDf_Qy0PbxZ5LSYYCbr3Z10ug@mail.gmail.com>
Subject: Re: BTRFS with kernel 5.4.1: df -h shows 0 Bytes available but btrfs
 tells me that there are 1.06 TiB free
To:     =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yes this is being discussed in two other threads:

"df shows no available space in 5.4.1"
"100% disk usage reported by "df", 60% disk usage reported by "btrfs
fi usage" - this breaks userspace behaviour"

Seems pretty clear there is a bug, it just needs to be located and fixed.

--
Chris Murphy
