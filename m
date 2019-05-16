Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D75AC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44C42070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558047074;
	bh=pU+UbpKpVcWj1khOiJXui8VbjH45eNmmfBXIU6dTFcE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VgouF3Dg49M5larMMzxy98FJ5s3XUfwae87R+AkwazB158ucyV5NzNGRp/5lJFaxH
	 +gP2uXQHCP9mYro3xXTfFh8Qk+U+MMweizTo6k2k9S8vleU6Tgl5AvgWUrZucGNTys
	 ZEBued1znrRzcIYVh+ZIW6McWnsmOTa7te0Nq0nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfEPWvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 18:51:13 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:38008 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfEPWvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 18:51:13 -0400
Received: by mail-lf1-f51.google.com with SMTP id y19so3889273lfy.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68ArjN0wa3lf1aOiRDVUTIQK5CrzgPXu4Jev+44ZCaU=;
        b=ZkmbJ6jP3obgZQ3rn0M9QXzzM0MDNkkO2SFtqSHyLYEk5pVSWq2QI4Rb39tCRjJ/Fc
         K4gBKQT45ncSY/sNglMvHT1MI2FqYxbfh2UWo26BC0aGzbF+0Go0S2rvvamSS7QLfU7w
         wEpr6052AXt0NMlwwtDFDzu7rFOrNcLcKznj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68ArjN0wa3lf1aOiRDVUTIQK5CrzgPXu4Jev+44ZCaU=;
        b=FcZu/E1ZzGsP4uCBbP0CJ3QPXik1M+wpVD9azHiwSmSFrar0S1YqX7KBGmLlptsN5C
         dsrfbBQN0joA5K4uLxT0XPItn8CRha7NbpFOJ2/yXHacp4ZSAo+MKS8l438A7BMKlaPg
         +WuWsgxzGGrWn4A3Pwa1A/sURj2aNCX5bsp2ZwSSyD9InOSLmZs7NWq5uenKGqOVxnCr
         Q6rh26qY2amY0qOsY0AjnkUgEXqiXJLM1vy1zqCvcwBx01NOpZnGJrxL4BUJRZYAC0FO
         4GNBBpRSZH8SaYcDSvWOLUwazWYhMr0UNOXcq5gZtbSBw0W7jF3B/gArPY/TKI3HLMyr
         xGBw==
X-Gm-Message-State: APjAAAWhUdTpXWFQxtB3nTWZZktANSxsRCui0yIoSA+Ojvo+nwmWeOwq
        fdB6pQEgJe5oKPUctvDNh/LUgJxjBwg=
X-Google-Smtp-Source: APXvYqzw2nGMNQam3mnq+K/ZPvedEwVRPMkKG/K9nrIkYb9+h1TkqoNArr+YROhYTPIWH7HCH9421A==
X-Received: by 2002:ac2:43af:: with SMTP id t15mr16078079lfl.45.1558047071729;
        Thu, 16 May 2019 15:51:11 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id q29sm1105458ljc.8.2019.05.16.15.51.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 15:51:11 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id d8so3871937lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 15:51:10 -0700 (PDT)
X-Received: by 2002:ac2:59c7:: with SMTP id x7mr21576802lfn.75.1558047070605;
 Thu, 16 May 2019 15:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
 <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
 <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com>
 <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
 <1558043623.29359.44.camel@HansenPartnership.com> <CAK8P3a0QsURY+QrkvBh5zS12cCLYD=ssVtus_6Q_DSnB1=1y3A@mail.gmail.com>
In-Reply-To: <CAK8P3a0QsURY+QrkvBh5zS12cCLYD=ssVtus_6Q_DSnB1=1y3A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 15:50:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+CyMkQJahExx0FNtJf+cd9VqjWNx3z6Em_xW11ScViw@mail.gmail.com>
Message-ID: <CAHk-=wi+CyMkQJahExx0FNtJf+cd9VqjWNx3z6Em_xW11ScViw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 3:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Strangely, the copy I have on my local machine does have the 'S'
> flag. I sent it back to the server now.

Yup, now when I refreshed your key, I got an update, and your
signature looks all good.

              Linus
