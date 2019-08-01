Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3191CC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0948F2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="etmtCIar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbfHASiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:38:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34492 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfHASiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:38:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so70395645ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRm0VZw0+vdPfuqKlyvMVmBBDH4QPYqnMrDhSJUTODc=;
        b=etmtCIarLpwD+He3nYQPx7WMrIItIUgF4WO27z/NtvDv+MRz2APxEgRTZD2hkOpuve
         3yc4ZvTFru2Y3nncQvXfwcWxMWeDmXilO7ffYdXfaCqTyZTN7zW6y4Ot5jBEzkRDwF3p
         Ke+I+G5YvZN2IekOO1h+1NM69qLjvXzIEFqa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRm0VZw0+vdPfuqKlyvMVmBBDH4QPYqnMrDhSJUTODc=;
        b=U4P2jgeY7WOUBsF8+9/LRaEIrHL+LjDmE3xgWzFl7IJLneqLlN7wX+DPXFiGj1wM02
         JZzVo/RLQbTRoeckjUXZDMaAsEAspyrot1rGt+vkmSaog5Vo/c2QnoL+Ah0tEsyuOZ+u
         fFBTktvs73Kv5y2asxJLw7GvmKEr8oiDa9Sx1KhryotMlsE0vg5PqbZXzOiHGBrnJSqE
         DvuAVj17QFpOoJsiFFDbSqT1ZcuzWE+FscowP4AFxU93TbyjS/NQT9G2mqUYnFY2cX7e
         G04RhLwGuSz7zGRllwT3KzFWE5Oo0snZPVkYYsvp88pmm7eflUWQKSP1baDNvjdcMBv0
         DxVg==
X-Gm-Message-State: APjAAAUr1FutpowPofynRfUeE36kjpmtdySq1IVnUhjFUMh0O0bMhW3Z
        Ty1YTnVScypeDv1Ya8qxa8Jtk3c65158FrRfM7lsp1gz
X-Google-Smtp-Source: APXvYqxiLgQc8yPSTvJJx1FN+yxZtvmHJa7Lew80a6w0JtLdvF5G6zzrVnklvhIoaraZOUirmH8zn+vON1NcelEoDBs=
X-Received: by 2002:a2e:301a:: with SMTP id w26mr67530395ljw.76.1564684694917;
 Thu, 01 Aug 2019 11:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190801181411.96429-1-joel@joelfernandes.org>
In-Reply-To: <20190801181411.96429-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 1 Aug 2019 14:38:03 -0400
Message-ID: <CAEXW_YRHtQB+9aVSK3Db1x_417=JvOnwtctte_r8WTS8+20EAw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Apply new rest conversion patches to /dev branch
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 2:14 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> This series fixes the rcu/dev branch so it can apply the new ReST conversion patches.

Weirdly enough, Patch 4/9 did not get received by the archive, but
patchwork did pick it up:
https://lore.kernel.org/patchwork/patch/1109574/
