Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6818C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 14:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876C3217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557585521;
	bh=6xMRak7Bv6swPh+iH1bNyQMam0bQnMP1VBv9ZeKVhMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RY49y1og2sT5qvG5wILIIxwM4FT86CDwNKsheIz3xNz0CV8yvs38hkREc9XevRLMP
	 DIdphneed//5ljljx0EkFGSZo4sUOiTF9kWurYD6r0Y8nXMrGGz7Jd6JAmPN53gpon
	 clMzfHGy1Vot7QddyLn40B3AyEPbt31FfmciW/IM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfEKOie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 10:38:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36037 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEKOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 10:38:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id z1so7432532ljb.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0nMY1dAXe3rU/EGGiXuIeNRBZ78Ma5ZAZuK2pC9YCI=;
        b=Eqgqu+RP5jF0lLzL+ebZS0xFoE2Nw9GZPEdGt2vF8FOu8+DBqY/apNwweFNq7lRwvf
         PrqvCmmZt+gXoClxsOuAkAVajcbrkacCcZDgJKHIaa8X0Jz/0A9OT+s0I74g4AJSdudt
         MY9SB7sftM339abzQfP8fe0j2sMPejVzDLY9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0nMY1dAXe3rU/EGGiXuIeNRBZ78Ma5ZAZuK2pC9YCI=;
        b=Ipe8nDD4g5D8bf3j/sTNecJtJs2Epd4QuJ2n6nNN1qrGhuK1bKp9+JmMJwsM6uK55B
         aQLiex+5e4M96GebIKZzQwI0dH1KlHP9XYc/CebzWFtEKe035fd2egWHSiMAtIzYIShQ
         be9s1ziBuj6OnLZPsHOOocVqGUb7yHhiYAi85bKM6T0vV2WxlM7frQcLltAZexmXRTlo
         5Ou0xDTPF36OBwk+YT0z5MTE8RlLYcR3ZQYxAeIjzg+R/3vyrZjuaU1wirK3Uq+zIIQI
         RaF8MmAYfZuomBPDKtrarV7OfqSwGOCAohO2eArbkusfhVJhKgPPVPN8o2pykjqVJyhD
         GrAQ==
X-Gm-Message-State: APjAAAVjVsZ5XaD8LmOSYK3/Dcr3UU7ELIBvDnniB8nbQxv1a9YLHUHp
        QuJL028mEzKSnhOpEURAmiHbTJMHqQQ=
X-Google-Smtp-Source: APXvYqyMW7TKHdvD0fZfKaEWquhNjIfhPAQ5R5v8ZUY5Js+I/j+JzwPRl3YAtlFbmNMhq1NtiRs+vA==
X-Received: by 2002:a2e:8098:: with SMTP id i24mr8716889ljg.88.1557585511036;
        Sat, 11 May 2019 07:38:31 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s26sm2062034ljj.52.2019.05.11.07.38.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 07:38:29 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id z1so7432487ljb.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 07:38:29 -0700 (PDT)
X-Received: by 2002:a2e:a294:: with SMTP id k20mr4024290lja.118.1557585509228;
 Sat, 11 May 2019 07:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1905110801350.9392@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905110801350.9392@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 May 2019 10:38:13 -0400
X-Gmail-Original-Message-ID: <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
Message-ID: <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 6:09 PM James Morris <jmorris@namei.org> wrote:
>
> These patches include fixes to enable fuzz testing, and a fix for
> calculating whether a filesystem is user-modifiable.

So now these have been very recently rebased (on top of a random
merge-window "tree of the day" version) instead of having multiple
merges.

That makes the history cleaner, but has its own issues.

We really need to find a different model for the security layer patches.

                   Linus
