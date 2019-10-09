Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB2CC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 00:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A122070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 00:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Ze4YkFtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfJIADx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 20:03:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42696 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfJIADw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 20:03:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id w14so797508qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 17:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=WqGF5bRn2qBJEYFx3A8CTfvZkg26MRFOSHOBN5dL4Zs=;
        b=Ze4YkFtBd5/DzMCSd2oh1KaJH6cGGY3c5lDfG6pSZ6jOxSQiT6uvs9O27SpmKr8rQr
         PlkpW/HaFdKu4XO0WSsE8IPz7r3ukK7simUgA/7KRYbxWRsgu1LSa31uflzrX8M5g1Cy
         ZPaDxwW2/6VuTDwJI4uasQVL5QX/GNIHGvJdT5O1EAkM0BpYxJ9u3LfFCsjmQaxgqIno
         ccisTei/iVWOxqNU6DOQnfxb0dOPxUae5mXVTpsl1KwpH0z/XS6KAscYbJ6tHVnSYV6U
         0CMSX821kQbAi7n8VRG2k5ArRMcP94PoEIbz0KF9Zo1Y6UbI1QkjYJUUmWaG6sZAUYCF
         IlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=WqGF5bRn2qBJEYFx3A8CTfvZkg26MRFOSHOBN5dL4Zs=;
        b=F7iN++pQA9EpY39sPS0bVykHB0o4+2F1iRYcrhL0wsr5pr58mGGk36WanZ/Ty8gLIV
         9Q/iNaG0tAweTScNV/uocqYec2ISoQWmg/DOEm8NMdwRjJ9NuyIu5UzT/xQjy1mPsJN1
         PRzMSMV3B7Zb1RrghiHQba10cJmS/mtHCR0qjQD2mfGD5Jx6KtXZjoqBASEHiYLBbhXH
         sc9/azxkrFhbwKOHHMOneGGEI2PKnYX3iIwPSk1sXIemNFB+46iN8/lEI3h94+ePpR7a
         AT2DNiWLCVJWJwaS3ywjHdHaO/o4cGOr8RX0wjVIHo+kB3r1E/0BuhkCGan60NgoSTX2
         CvDA==
X-Gm-Message-State: APjAAAXuAyzxfzSW8jILgUNL9zdrjplzNFA2ujfe2jeVjIOnDZKHWgGE
        WN2PpjGmreTS0Q3QIYk+mL8DTw==
X-Google-Smtp-Source: APXvYqyIADhe7dvws8woSGcXlrTNvM3J0iaMNtO4UCC2BKh5+RZ9ipEJU27LBFUsyJIUN3nA3SIVjA==
X-Received: by 2002:ac8:6952:: with SMTP id n18mr684128qtr.297.1570579431767;
        Tue, 08 Oct 2019 17:03:51 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id u17sm153412qkj.71.2019.10.08.17.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 17:03:51 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:03:39 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Rusalin <arusalin@dev.rtsoft.ru>,
        Lars Poeschel <poeschel@lemonage.de>,
        linux-usb@vger.kernel.org,
        syzbot+cb035c75c03dbe34b796@syzkaller.appspotmail.com,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] NFC: pn533: fix use-after-free and memleaks
Message-ID: <20191008170339.5b0843f2@cakuba.netronome.com>
In-Reply-To: <20191007164059.5927-1-johan@kernel.org>
References: <000000000000f0d74d0594536e2c@google.com>
        <20191007164059.5927-1-johan@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Oct 2019 18:40:59 +0200, Johan Hovold wrote:
> The driver would fail to deregister and its class device and free
> related resources on late probe errors.
> 
> Reported-by: syzbot+cb035c75c03dbe34b796@syzkaller.appspotmail.com
> Fixes: 32ecc75ded72 ("NFC: pn533: change order operations in dev registation")
> Cc: stable <stable@vger.kernel.org>	# 4.11
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied to net, thank you
