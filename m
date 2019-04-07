Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CBCC282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59DD20883
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNvaXLuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDGWKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:10:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35610 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfDGWKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:10:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so6146812pgf.2;
        Sun, 07 Apr 2019 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gEad8wPBFNEsqszeoMcA8cA5OhvBJ+fB9LA3q8nigao=;
        b=GNvaXLuLplMG5J9/CdgzgpjRF2jyK5nzoaDfwrfXUS+ZyL9SESlXw6a5IbE1mfQmIY
         Dm91TmjOrEGAl3odghmmERjNK+BRDc+a3AkvH458NIPoKniTpI2YbB6dzEdU4dPMFnkf
         zQ5y9sEHzQzDYCxtMyILxkeurZsz3kuxZubi5awjyZYlSHxvYXQa8abWADPRJ/lD1Kia
         DPWfjHVVTx1UIUh8JA4QepQoFQgrSpUhG+/xdA+LPb+tpnyzx29tMrMU1Dta0kT9Vjic
         9mW+6LxtaftCa4x1NVfh/Z9jjVzut7LEpsATSo3hFYImXKrKyKivwkZ2soknnSOyct2m
         sL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gEad8wPBFNEsqszeoMcA8cA5OhvBJ+fB9LA3q8nigao=;
        b=hDhAwsAPOnjxRtxuA6+kTVZQon1Y1HMlCksIvePI/nyhlLAsags+ekBLZlpEomwo3Z
         ta+ZCj4khKkw1IV8Nhi9fI06J3p7dayFsJMY3LccUv/TnbhqAAMimclBnaVP6GOU496w
         /uB802H9cbMhaHT/I/f9ocSZ9au5MjtNc2WHmB41/9PW0vQpIz2xmUzm6GKA55sRFYX5
         UG/4K/VAEnHSHj3PQDetI0m4coNuWvIr1c53LzrTG/UUnIFLvvzOTDu5u/PlK4yJ+5XW
         jqBEfny40Vq3eXbDSbTzbeIOhk9cVUpj/JVJFErFU1Q5HWYOw+bbTkZNnSSMWM/tE5ar
         PlPw==
X-Gm-Message-State: APjAAAWsnRrCCg6Fuh/ZPNEP4F1V0TpQad5uGX934DoYqFa1YiH1NeKv
        u40j7QnpKeIkLoGA4/za8Ko=
X-Google-Smtp-Source: APXvYqxZ7p8xpjEay2fij1PLrOuJ9toXMWxrxjsQVcSDne8JVHURvBTAw2eARdHhiTwf8ad/o5bhrQ==
X-Received: by 2002:a63:ef0a:: with SMTP id u10mr7171720pgh.199.1554675037340;
        Sun, 07 Apr 2019 15:10:37 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k14sm51968450pfb.125.2019.04.07.15.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 15:10:36 -0700 (PDT)
Date:   Sun, 7 Apr 2019 15:10:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - disable KBD port on Late-2016 Razer Blade
 Stealth
Message-ID: <20190407221034.GA162359@dtor-ws>
References: <20190407213735.10658-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407213735.10658-1-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lyude,

On Sun, Apr 07, 2019 at 05:37:34PM -0400, Lyude Paul wrote:
> The late 2016 model of the Razer Blade Stealth has a built-in USB
> keyboard, but for some reason the BIOS exposes an i8042 controller with
> a connected KBD port. While this fake AT Keyboard device doesn't appear
> to report any events, attempting to change the state of the caps lock
> LED on it from on to off causes the entire system to hang.
> 
> So, introduce a quirk table for disabling keyboard probing by default,
> i8042_dmi_nokbd_table, and add this specific model of Razer laptop to
> that table.

What does dmesg show about i8042 for this device? Especially line "PNP:
PS/2 Controller  ..."?

Thanks.

-- 
Dmitry
