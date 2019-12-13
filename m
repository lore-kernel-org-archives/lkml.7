Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DA1C7DBC9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058DF24741
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Rqg/Ovmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfLMSWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:22:49 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35517 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfLMSWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:22:49 -0500
Received: by mail-io1-f67.google.com with SMTP id v18so368808iol.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 10:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HpocJd7ZVW8aqsXghWaXWyBEujhMqhHxlf0cK+XS6no=;
        b=Rqg/OvmizrBtTm3kiJrpDSeR1+kUYCkrSayQpyg6tZ1FpM4zpcENIWmluYZCNiLQsf
         mcnIyNhSdvU7L13bX7IFVftUuiEqUZ03dqGoWi8vAT+thWksY7jy0hD/05fwtmRGpZpx
         WjDbYiPt23rEi9W6Ews0hOUuaFpAM+EGAK3+6VhoAqbuoSH4MJTJyZk91WRzw90R0SQk
         3bvTUPIwgI/lq9J/QmW8xtf0t/Emw5AIqCvsQ5IOX1fQ6JqIeLyDUTR0cezcIeaCWFo3
         MDPlTX3F8LKzr7Vjs62YyJNnydUO/HK/ZWS6tTYp5A5a0/xnamNwxE8HxxKMBgojXuBQ
         2l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HpocJd7ZVW8aqsXghWaXWyBEujhMqhHxlf0cK+XS6no=;
        b=dH1a+ijRfnP2QtsT82GcTWU9i4INr5SIOyXhp/eP7OyiERYdM6KEK6QRav7i6vvUxO
         IlbisePkAAUtzQrJ1j4isK0tJtmCnDtgGlsyxTludHqN3qDk1oOSalm6MoDOLx5gzGad
         z1FWtK7PFudN78u+HcDiM+SLSKh6+R7EjyJ3lUyeyFxukTGGagYnX+mtEx02iXlPby1B
         LYcF4pJ2pHfSPzpozPDNWbio1kbjprYbdzHsYDC8FaNKmwpm6pUquwyjJNarpjCxBHbg
         Umrjn/HCrcJ0xUng1i+Vh5XnskRJt8dtTQEufURXRqgcLerXFTz9aoPsTRSZ/PhC7DOg
         mIlA==
X-Gm-Message-State: APjAAAVbCQxA+JQCqyfHaejrbIDTlnkhhILh/5eBzVzyOOiIPLwvj88N
        niXIVTGIL2u9JrdljJPG4Ktljl2I5/Tx6A==
X-Google-Smtp-Source: APXvYqz+nYGKX4SR4hvzE3Dwrf1y/0vzAsMTfcVHoDmJ3j+QwRWGkOVLGygSmd4UPTRiWG+hkQIUtw==
X-Received: by 2002:a6b:7b41:: with SMTP id m1mr8002940iop.191.1576261368225;
        Fri, 13 Dec 2019 10:22:48 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d7sm3018102ilk.11.2019.12.13.10.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 10:22:47 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: don't wait when under-submitting
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5caa38be87f069eb4cc921d58ee1a98ff5d53978.1576223348.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <21ca72b0-c35d-96b7-399f-d4034d976c27@kernel.dk>
Date:   Fri, 13 Dec 2019 11:22:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5caa38be87f069eb4cc921d58ee1a98ff5d53978.1576223348.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 12:51 AM, Pavel Begunkov wrote:
> There is no reliable way to submit and wait in a single syscall, as
> io_submit_sqes() may under-consume sqes (in case of an early error).
> Then it will wait for not-yet-submitted requests, deadlocking the user
> in most cases.

Why not just cap the wait_nr? If someone does to_submit = 8, wait_nr = 8,
and we only submit 4, just wait for 4? Ala:

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 81219a631a6d..4a76ccbb7856 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5272,6 +5272,10 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		submitted = io_submit_sqes(ctx, to_submit, f.file, fd,
 					   &cur_mm, false);
 		mutex_unlock(&ctx->uring_lock);
+		if (submitted <= 0)
+			goto done;
+		if (submitted != to_submit && min_complete > submitted)
+			min_complete = submitted;
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {
 		unsigned nr_events = 0;
@@ -5284,7 +5288,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 			ret = io_cqring_wait(ctx, min_complete, sig, sigsz);
 		}
 	}
-
+done:
 	percpu_ref_put(&ctx->refs);
 out_fput:
 	fdput(f);

-- 
Jens Axboe

