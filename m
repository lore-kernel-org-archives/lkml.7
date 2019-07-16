Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB60C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E112173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpCqwPCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbfGPXWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:22:51 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40300 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfGPXWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:22:51 -0400
Received: by mail-vk1-f196.google.com with SMTP id s16so4561103vke.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjpiai5hkCYLL6Diojv89YWK7LVysGGzfUoUrfBoeQ4=;
        b=RpCqwPCvhvOPAtlSlatjK+atlcOC50FQcSClS0zKZgzBPDO/DW9MiVWDoZF58z5MdB
         fnyNbMK3RMD8HWeS3xtOcaJ5UaNwSop31ZerBzqTWC0XCvKIsd1S8s95vHljNbcIZWXE
         fI5qKOqIfdpP3Hm/+0L6i62IX70ZMgzJc4HqcoGlLbXi3l0P+f6a+f0T1CMKj356LoWd
         mH1CD9c8Pr7oWbnQkDunKHAZE7tI6iiPcWQyHiGGYiNIZQhRWEAvw4YNZho4wxeVkn8U
         AVpyxNe1w6+FrA59cJIayB2b/wKm+AVSzszC68evKv0kBMXA36YaJRP0LTi1WGRp4Zfu
         oi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjpiai5hkCYLL6Diojv89YWK7LVysGGzfUoUrfBoeQ4=;
        b=MqPBDWB5jptijezC95aUNUBH7P6l31yAAPLoHdwhPzcd6ctAjnAcTaTXxQ/4+w6Dvi
         tOuVgkckhMvcqntnLh3++N+qbDAerIn2CCyr/tU1JO3yzMXOSEZLqlV6IAGex8eMd6M2
         giYtI/nxIPh3NKkltFCm3T9dV/C02bUtYEArRBe8+feHIyPs47i+os0xuEozlpdl65hO
         X8bwXI0tGo05R0s2heAWqNTE5CpokFbd34z0j4TTTKJ2S2s2UYVBfAgUJ6Dlh+/kLIto
         eVHzeyd5jojmmHBZF8egV3UU25FBaWSBT09cTN4xEnvcrST/L3BWzmv+aUbRqO0rtpRg
         rtFA==
X-Gm-Message-State: APjAAAWecLkJGmm5GkztEHmCNMRfdwlgyKTWmk47gSi7+CW+K1B9Nwaz
        G00lJCELfecKLxH2MsENj3alGzJqUbVozsEyvXbKuA==
X-Google-Smtp-Source: APXvYqypcm143UE8WXo2p4xQIYE4/nSLIYw9Jmalgee0YoQ3TxaTvtAIBcOrWMDEUoeTN8IBjeyCTb/bN9WDKfiOz14=
X-Received: by 2002:a1f:3dc1:: with SMTP id k184mr13794381vka.24.1563319369484;
 Tue, 16 Jul 2019 16:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
 <20190715195946.223443-28-matthewgarrett@google.com> <20190716191439.59a1ac32@gandalf.local.home>
In-Reply-To: <20190716191439.59a1ac32@gandalf.local.home>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 16 Jul 2019 16:22:38 -0700
Message-ID: <CACdnJut3FDAqpELYOicR9-tYCF+G_213J0nGJHeR5EPqXqToVg@mail.gmail.com>
Subject: Re: [PATCH V35 27/29] tracefs: Restrict tracefs when the kernel is
 locked down
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 4:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> Small nit, but please add this as the first declaration, to keep the
> "upside-down x-mas tree" look. I know some of the other functions in
> this file don't follow that (which should be cleaned up some day), but
> I'd like to avoid adding more that breaks the aesthetic of the code.

ACK.

> > +
> > +     if (fops)
>
> I think you meant "if (!fops)".

Blink. Whoops! Yup.
