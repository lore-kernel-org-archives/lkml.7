Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBCAC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FB42072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D35Tnx2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgAIXm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:42:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46363 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgAIXm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:42:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so52258pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 15:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=YoRMhkZec9G754MeMpA3qyugr+9dP1r59sqNei59Bxc=;
        b=D35Tnx2qGOx5wYEODGub+OOGjjHIMqMro6ZmZhmjSXbAHjXU4M5d+fM8W0jNKs7+j2
         pjfHSASWvUBuPPbYqX1zPamNaz8n/fgfkW3ia4D0vunpEH3G+pn7KYoDTYQ/gG/mJmiI
         yvZhtWf9RkHB/m27NI/0O95YWzWaozyWygAmOBOOH9UhFnVVrTjxMRW8ZbQn1QaP3OEX
         rNaAhVf79aDKtq/2Xk6l1ta2KLUAW21SNVr+6upC4MdJCHtaXtPWLfl6yWgm8BV8UqeO
         loFErmafn0is/MVcTxKX6E3dgn4/Latu0qWQMrtB1090RsCxe1i3fPvJhggAfshogVe1
         3jtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=YoRMhkZec9G754MeMpA3qyugr+9dP1r59sqNei59Bxc=;
        b=bmsBhDnKIhBLoGwPHXZFUDxSkOH7B6AvvM36XZZ2ApOJImTX4RlXiRKiH2oxXmdxXw
         UVnWUCfqXRqNkL/LfHf4YY7Y7NOrQlIs8BRLbqzkZkuz/WrAKZARZ4V2rrhwO0JFA24A
         NEoa66EhgEKi00eq5LkwQe43TH2eoZaj5wr9rJDUKiOroRcKWkOcOCHz7c2jnPvEDez/
         fNFWEeJgdNTIUFqc5TF06sc1//u/lztzgFw/EDScDiGnXGttOhPER+KwSZWdQet9fjnX
         o5M3cOMl5b59DyjhFtqBtxTCms6siyGVt6BlhDXoRsNke2LCkX6UNn67znZkS4EKl1Nk
         iGKg==
X-Gm-Message-State: APjAAAXuqfi6sWIei2NT0OuacBbFn6FeMrTVw510IQCghFN1K3nbPhlh
        2nWz1/2H7Y4uJQL64LQK7+6Gkg==
X-Google-Smtp-Source: APXvYqymalA5zmwiQNv0P8QaSMt5qB4BiTihWTnSZaqORKmMdLg29qW7g8n0TfOd8rT3pRf6yvOpUg==
X-Received: by 2002:a65:5281:: with SMTP id y1mr575543pgp.327.1578613347669;
        Thu, 09 Jan 2020 15:42:27 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id o14sm38329pgm.67.2020.01.09.15.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 15:42:27 -0800 (PST)
Date:   Thu, 09 Jan 2020 15:42:27 -0800 (PST)
X-Google-Original-Date: Thu, 09 Jan 2020 15:34:58 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH] RISC-V: Typo fixes in image header and documentation.
CC:     Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, merker@debian.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-doc@vger.kernel.org,
        palmer@sifive.com, mchehab+samsung@kernel.org
To:     corbet@lwn.net
In-Reply-To: <20191210072947.7018340c@lwn.net>
References: <20191210072947.7018340c@lwn.net>
  <4912c007ab6c19321c8c988ae2328efbfb3e582d.camel@wdc.com> <mhng-3a815562-1222-4737-a77c-6dab9948db79@palmerdabbelt-glaptop>
Message-ID: <mhng-94b9cad5-0d14-480f-b428-8752630064d2@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 06:29:47 PST (-0800), corbet@lwn.net wrote:
> On Thu, 05 Dec 2019 15:03:10 -0800 (PST)
> Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> I'm assuming this is not going in through the RISC-V tree as it mostly touches
>> Documentation/.
>
> I was assuming it was going through the risc-v tree since it touches arch
> code :)  I can go ahead and apply it.

I don't see this in 5.5-rc5.

>
> Thanks,
>
> jon
