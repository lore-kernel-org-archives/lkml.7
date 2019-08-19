Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3196C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA0B205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566233093;
	bh=Ye/IL7qi7ntpWlo7GGNzyZeXk2i5RgzzrtIV4cW/m+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lzrBxB0zd0O2xo8l/t/3FK6I5I2Jgcvn+vv2UbK9Oh9TDLbqniTRdKl+nrgoonN3g
	 pBb665F1WoN5FJzfVB4jGQ05BrFLQBLVizDGE43UhGmXxyonLpqbb+lr0gGBcyxnCp
	 /B/4HWM9af+N8DRATYxutFhvqBWqqUnLoOsr2oyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfHSQow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:44:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46305 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfHSQow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:44:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id f9so2387207ljc.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTgEEhnQW7rA7Swk7XmZoE/TVWKiM/rYLloBH44I1Y4=;
        b=HXYiO3uvFIJxP8AzLPiB1vCojk2HYF1PHjHSec/oU/g4xnNPfhabSnJiKWyvKhdvPL
         PSTBApqcqrNATd12uSC/OSvm8TCRNPUsxfylRETL95enFuQ/shakvQqEAneNqGoKLzuq
         zpeeR8Q32NiN+R8GM+dAc/To+08EVo1OrugEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTgEEhnQW7rA7Swk7XmZoE/TVWKiM/rYLloBH44I1Y4=;
        b=IOY4zhnAEZ3pUh58Jz8ZE2C509Ky31+B7mq5KA1M3wPYiQkE3tszHuplK1JBEEnc9W
         PFOOSuw11zJa27Wcod+MfGelzzk1zeJckvLtOr+2FOpMwpK3m/duGy0BE0+tXrax8oG+
         p3KK/lyuCVV8h+N8B5EyC86J/YeCPoQFcWxXvX3bq9759+y/mxNq/hebRcTsSmA+9lIi
         haExFfCeY8suY+ypRO+rDYCvKndKQyNnoN8Ij+Imd9m5LAw5OGIRSq/vpPtwHgsjcsr+
         Tgxz0eJUHwSf2D5ap7Po8DUsiLxoBZJxAw97PB5K1OkkaUV8eU3Wm8IqlkUcjlAOeNK7
         ahyw==
X-Gm-Message-State: APjAAAXnmgXDBhqCVRUI95M92A58yqhTrvY/+2rZ8RE14zhf1oy6DF4H
        CLlf97yJAfLmrxF4J2DBREbXORRHzHk=
X-Google-Smtp-Source: APXvYqztvNeDVitdzUgN497Lg/MdBoMc/0BMMIBmsDBAm0jE9JuenzuWsdS5e8BzCgem23FkwQhkyA==
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr12831700ljj.201.1566233089457;
        Mon, 19 Aug 2019 09:44:49 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id f17sm2395026lfa.67.2019.08.19.09.44.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:44:48 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id h15so2389954ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:44:48 -0700 (PDT)
X-Received: by 2002:a2e:88c7:: with SMTP id a7mr11508843ljk.72.1566233086820;
 Mon, 19 Aug 2019 09:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <156622692131.21558.12335114959426121841.stgit@warthog.procyon.org.uk>
In-Reply-To: <156622692131.21558.12335114959426121841.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Aug 2019 09:44:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiP7j+vzthU+wokF-PfR-CtA1YnwT6tYeNO9HK1KWUpiQ@mail.gmail.com>
Message-ID: <CAHk-=wiP7j+vzthU+wokF-PfR-CtA1YnwT6tYeNO9HK1KWUpiQ@mail.gmail.com>
Subject: Re: [PATCH] keys: Fix description size
To:     David Howells <dhowells@redhat.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 8:02 AM David Howells <dhowells@redhat.com> wrote:
>
> This can be fixed by simply increasing the size of desc_len in struct
> keyring_index_key to a u16.

Thanks, applied.

              Linus
