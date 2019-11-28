Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1C6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7A7216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak2QGyGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfK1HpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 02:45:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41781 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfK1HpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 02:45:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id e9so22534977oif.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 23:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8kiJRE/B/wxbSXxZog9CBfpnC1pt1UKvSf8bBaqAJYE=;
        b=ak2QGyGqDHCjy7nbxkPXZde6Lx0OpuNAOr4gm0HSsjNPc657oJGqKn6WEwgB4ajJ/I
         Fqb1vZbxmKjobjecJ+hpBwzIVooddcrgVbGa6Y0FWnKkrH8FX9KX9yyahyWSm2hbnQKG
         iSFbL9EeJKB8SPQ8xn1Y3SbzzW6suYeWoTil2XA6Mo3xJKKnOwJFOI13NtgXbcdXUfcF
         w2MQB0nzU2xEV0niOetqUjL7jPw/1XB054wyc8G5L7vOZVnKKnymX9kmjcQCCP5APHbi
         CEkVMlgisgiCZ028mcD+Pvg/P2QGAE/n4zJajeimCa07k6dUcbMNPj7eA2MRd+gTfTxf
         uvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8kiJRE/B/wxbSXxZog9CBfpnC1pt1UKvSf8bBaqAJYE=;
        b=nISi0ICU1cFhHVv7BuXopY693I9OrUJbP6Imoe+jIIFP9dw+5NqOnARFcy/NKsDlQ4
         qwE8tCsCYDS4JCvKzPgX5j1zkx6vE9soanruiupQBiQSH7Lk4ogZSFgNHrBQlGoPHj0i
         1wEY16OSK/CFzP9mnlelgiliCxzz6ePbC/HTbgZ7cvOvkRbncoTfWDPHptFavj6vvHlq
         ZXhLjBaQJ1R8LQ+Jg65XJdt3pEJuKlg3PEY4Ks88SX1rEMzREP3qAmStRQY1yujt+cSx
         rluPU/AypT4A+rGcPmYsgO+fct/msTs1lH3jU76v4cf9xfHe4VwL6Qhgw5Js5aYyOBqJ
         Rqlw==
X-Gm-Message-State: APjAAAWr+iX5VoJzp96LCFFnO/AyvvEkNBX3Y8PFokPKcAKp9jv8h8Lq
        /gBm6uFEokAuYRQv1bn2iRI=
X-Google-Smtp-Source: APXvYqzaD4ywu4vxa6MdhVQTJ1iRNw5fZuuhJQbHb3CLlD4zmMqcmTlyzdF1HhQzEf3yeKQW+1/uzw==
X-Received: by 2002:a05:6808:6ce:: with SMTP id m14mr4510556oih.27.1574927105893;
        Wed, 27 Nov 2019 23:45:05 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::7])
        by smtp.gmail.com with ESMTPSA id w2sm2657096otp.55.2019.11.27.23.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Nov 2019 23:45:05 -0800 (PST)
Date:   Thu, 28 Nov 2019 00:45:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v5 0/3] LLVM/Clang fixes for a few defconfigs
Message-ID: <20191128074503.GA37339@ubuntu-x2-xlarge-x86>
References: <20191014025101.18567-1-natechancellor@gmail.com>
 <20191119045712.39633-1-natechancellor@gmail.com>
 <CAKwvOd=3Ok8A8V30fccK5UzWFZ7zwG_zvGQV44S2BK4o2akbgw@mail.gmail.com>
 <87v9r4zjdw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9r4zjdw.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 03:59:07PM +1100, Michael Ellerman wrote:
> Nick Desaulniers <ndesaulniers@google.com> writes:
> > Hi Michael,
> > Do you have feedback for Nathan? Rebasing these patches is becoming a
> > nuisance for our CI, and we would like to keep building PPC w/ Clang.
> 
> Sorry just lost in the flood of patches.
> 
> Merged now.
> 
> cheers

Thank you very much for picking them up :)

Cheers,
Nathan
