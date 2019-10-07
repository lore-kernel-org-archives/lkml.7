Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1843BC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75B52084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSlsS54z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfJGJKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:10:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28143 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727262AbfJGJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570439423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyyKScmQhEAZVNkzHwbTVOTJjSJ/MJlKx+aVNyzmssE=;
        b=jSlsS54zLz2ExihxvEpHKH3YnFiMGfiRXcc5ah0YiaawHXAiKdYZyFMtPRNL2lGg4AY9ck
        ffvdxhQ2NF2Nj6T0nExCuOLFXSki4pUKOgqBDVf05v8RxMBJk4C85kFZNLMPlmGLjLH/F4
        m865p38LHA7AiJfj8yMMMQUj661Yjys=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-bcYbVBf3Nayl1oAfZFzPpw-1; Mon, 07 Oct 2019 05:10:21 -0400
Received: by mail-wr1-f70.google.com with SMTP id k2so7209265wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 02:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qXE2Citr/8gr1JVjJBCMqiWsD3hna3z+ynmhIFXHtb4=;
        b=MJgsahzz0NZ3gVZrvDETNV2hiFiZE5Qa03ZqXZsShCWk55gja2uGWhUtXf+kCH1m1i
         /kGMDwTtNNy3TewRxyxe2CVsGMrMc1sTQIMwy4N4ukNgVUbmtr382OIivY8TLWyvP7Bb
         6he04+gAhZ7qEhEKNUabpZgmDat8fUelWcnVRJBxxc4+YpxGUXUa3wdOpdwXg1MMcTso
         JYMvSAFAQkXOR1yLcaEdMJpbs8S2mbyj+flBCanqXPyrQABIttwvJAK1LcYSJwMHItOp
         EDNwk1vTRAITxgpZXZBEPvLQ4GTbtfm9S+BhfVKFH/xk44J8tdoVKq8XGF6bXPvYGjTb
         CF6Q==
X-Gm-Message-State: APjAAAUfEu+3n86i8iqE/UpO7auj3To1cocsXzay3lNjJuiDsCxv/xxb
        ghub2AI4VPwUVg6x5E4MKzZbxqtTsDKqhmLRfLz/9HBcyeLKaowmTB83ItNuPQiHyl0kk0Lbf2F
        tSljeDgX6dYg5oes4MmWfzC0k
X-Received: by 2002:adf:dbce:: with SMTP id e14mr20591480wrj.56.1570439420124;
        Mon, 07 Oct 2019 02:10:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxStTduMm8kpGBl8hWM6IaloJlvYLncDPttcc8ZQenpMUhw/vRO8e70iEMPgh+GYbg+zu60VQ==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr20591452wrj.56.1570439419954;
        Mon, 07 Oct 2019 02:10:19 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id a9sm22019164wmf.14.2019.10.07.02.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 02:10:19 -0700 (PDT)
Subject: Re: kexec breaks with 5.4 due to memzero_explicit
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org
References: <20191007030939.GB5270@rani.riverdale.lan>
 <28f3d204-47a2-8b4f-f6a7-11d73c2d87c8@redhat.com>
Message-ID: <0f083019-61e8-7ed5-dde7-99e1aa363d9c@redhat.com>
Date:   Mon, 7 Oct 2019 11:10:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <28f3d204-47a2-8b4f-f6a7-11d73c2d87c8@redhat.com>
Content-Language: en-US
X-MC-Unique: bcYbVBf3Nayl1oAfZFzPpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-10-2019 10:50, Hans de Goede wrote:
> Hi,
>=20
> On 07-10-2019 05:09, Arvind Sankar wrote:
>> Hi, arch/x86/purgatory/purgatory.ro has an undefined symbol
>> memzero_explicit. This has come from commit 906a4bb97f5d ("crypto:
>> sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
>> according to git bisect.
>=20
> Hmm, it (obviously) does build for me and using kexec still also works
> for me.
>=20
> But it seems that you are right and that this should not build, weird.

Ok, I understand now, it seems that the kernel will happily build with
undefined symbols in the purgatory and my kexec testing did not hit
the sha256 check path (*) so it did not crash. I can reproduce this before =
my patch:

[hans@shalem linux]$ ld arch/x86/purgatory/purgatory.ro
ld: warning: cannot find entry symbol _start; defaulting to 000000000040100=
0
ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'

And I can confirm that it is gone after my patch:

[hans@shalem linux]$ ld arch/x86/purgatory/purgatory.ro
ld: warning: cannot find entry symbol _start; defaulting to 000000000040100=
0

Regards,

Hans


*) I tried with a Fedora signed kernel, dunno how to trigger this if that d=
oes not
trigger it

