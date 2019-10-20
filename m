Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D49CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 00:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C1220854
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 00:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egbcuwMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfJTAcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 20:32:50 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43671 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfJTAcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 20:32:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id b1so6546297vsr.10;
        Sat, 19 Oct 2019 17:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=K58Cs3RFhDfIknOUmW0iaSQCOF5QfHvEO7+Y1rqr0dE=;
        b=egbcuwModWi2/B79OYSDBS+jOBYfsoZQFisNM7CbuR0ku/iWB8qPbMpWQ1MmyVPZ8T
         vWWOMiCciYGNJ0BlM1eYKQWEb3LwmCux5PzWke2y3Ml7p2l626PIy/IGjFNJ19uU4zz6
         c6s3TP+uUCGoXCsBpr/ujFpXIGM88i/V9+BfD3k1YXigJldB9IpO4pGGgccB1VHVQk8k
         jUUI4Ghi8q0t/n7uV3ZWnjMoSDwB2QOeppS+jszwhmiiwfAXKYPZMvUJbl4Foybo2GZ1
         QVqn/JusQofFhkr0s6KFbI7SXlQZM7EDEfm2MypI1lokGOuGj1XM1ZdZGDtKgFe7Xm+h
         cLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K58Cs3RFhDfIknOUmW0iaSQCOF5QfHvEO7+Y1rqr0dE=;
        b=APxjcRk98wqvl1I2Hh/rYqAoAK+wb9zgTq3C2JtbwvDrrQKvJgU1QIuiwwidhSdFiS
         xTRbCg8BNhQBaOxgcRvjJSGjfNE1aYVxyVcJ4zj1ixhCq8dr2t0FXU5okrp7FWQOx6rJ
         yvmP10bDDDA13uuT7DLtFB7FjJIBATJxoL4TcJ/Q7VTvNEPoHheUNUrZNpfPh+xO9+t1
         3YwpP5O6Ub+rudLS2op3g/WtX8TRLvaqrPxxRux7iL50/sd68jnlW8fvtC99ecg1Db5j
         PwdqPJn/QFNyGP8dYhNoExfyf/xIMkf1Bj1276NqbAw/T+H7YR5dRILLFYPIp9PH4hAr
         X4zg==
X-Gm-Message-State: APjAAAU9uWI9EyiCcQy3BfFS5/7viQ6CVUgUdYUl7VPBxOYS0WRfLZJq
        KBmuuE+x4hgsnL9HUxIYEw==
X-Google-Smtp-Source: APXvYqzef8ioByAKlYieJ69NYwdVGT9COrmu2Rl7xeQar/ZQzCGfYTvAhZUXOvXlEHu6tRssN9mx5g==
X-Received: by 2002:a67:e281:: with SMTP id g1mr9866092vsf.16.1571531568694;
        Sat, 19 Oct 2019 17:32:48 -0700 (PDT)
Received: from 960ws ([2601:901:202:18cc:6890:3fdd:51d1:9d8c])
        by smtp.gmail.com with ESMTPSA id q2sm2527148vsr.21.2019.10.19.17.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 17:32:48 -0700 (PDT)
Message-ID: <058a2a50d9a819a5e87d526f986b8bf2017b9671.camel@gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: huawei-wmi: Stricter battery
 thresholds set
From:   ayman.bagabas@gmail.com
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>, Takashi Iwai <tiwai@suse.de>,
        kbuild test robot <lkp@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 19 Oct 2019 20:32:45 -0400
In-Reply-To: <20191019082855.GN21344@kadam>
References: <20191018224221.15495-1-ayman.bagabas@gmail.com>
         <20191019082855.GN21344@kadam>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-10-19 at 11:31 +0300, Dan Carpenter wrote:
> On Fri, Oct 18, 2019 at 06:42:13PM -0400, Ayman Bagabas wrote:
> > Check if battery thresholds are within 0 and 100.
> > ---
> 
> Thanks!
> 
> Don't forget to add your Signed-off-by: though.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>

Thank you,
Ayman
> 
> regards,
> dan carpenter
> 

