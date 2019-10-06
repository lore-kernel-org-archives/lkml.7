Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D9EC47404
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CDD222C5
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 02:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXbR5lRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfJFC3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 22:29:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46167 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJFC3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 22:29:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so11203836wrv.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 19:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YGXf9idAJ+CJ9q4yeCvmnDfU8PF8I7CxRLbmXUnGvaE=;
        b=bXbR5lRlZwWTXVwvK015DgZNC+gXgMsDlm5stxRvBjFYfgSjZrLk1/gDpV5MWxUr4V
         foOM8irTZsUCyvzu7zQaH5tnxXU7lbho45WPbYYlJOZ12WnBymVvmCfVWU4gRJ6wsnoz
         toLpbD5R53JK/imQA6T4vwVRqF5FhgLSnwSBLii8itUaBoYiVJtIh8ytJNbNi87k16f/
         lrZsfLFqg0Y3OEV7sisBz3AIg9+hKLKYfX6AZ+UhzM5F2ohQKK4jii7OStNX6WNSi1HR
         gyOAVTAEspNzDwu+TqI1JElFNIo6ZXsqlB6svs2rbqEa0Bj7ZPpDVXWAXKFjJTpcNNfC
         GIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YGXf9idAJ+CJ9q4yeCvmnDfU8PF8I7CxRLbmXUnGvaE=;
        b=EN8Te1fTOAy0YtZD9NphBEtAOJoEvXfhfhkRS8+RsgCLPkJQ2rzoc2ii0y28KbgsVq
         lqwlAvhJVMRbBSMUxqdgU7RuuoiI5kt8lTMcZzQqukuRKHpzy38vCpIJjAb60mr7aw2p
         g+4M5aFjZamOF65OZgUK+4GB8mom3R331fq+RVlEY1rVA1zoq7IA2E0H4hnbluFC14hF
         k4Tkd/nCZuqSpONT/y9yK0HnklexkfXOd6eHmcDIHkGQJ163Nk9dR7PNwnyqfzXkq1Mn
         yed7e1ZiqmVbGdr6Woh68yr/oyXQ2xcuGKGz4Wwd0MnpOWsAOtZ1l9lnyQf6Tsv3np84
         HeHw==
X-Gm-Message-State: APjAAAWcGd4KizRmULE/da1CKkBW3JW6KmoztCZiZThml/7tsTfRwMNB
        7iJM8dsl5yPAMcKwBq/D4jU=
X-Google-Smtp-Source: APXvYqwYQEIzRU2OOoOL/M1kz1QfCVsYvxsYYZynX93oCN+/Z9SdM15Qdv6y6grRKFvRgKDzQpeJXg==
X-Received: by 2002:a5d:4d4f:: with SMTP id a15mr17546051wru.267.1570328990269;
        Sat, 05 Oct 2019 19:29:50 -0700 (PDT)
Received: from mail.google.com ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id w3sm828162wru.5.2019.10.05.19.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 19:29:49 -0700 (PDT)
Date:   Sun, 6 Oct 2019 10:29:43 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: determine whether the fault address is canonical
Message-ID: <20191006022941.pvwldrjyhl4z5inu@mail.google.com>
References: <20191004134501.30651-1-changbin.du@gmail.com>
 <CALCETrWEhNCWDz7OVpbYJceJ5eShsWWhuyuAQQSzAdKncUo7zA@mail.gmail.com>
 <2d078dbc-73ca-0868-71f8-16e413ebdbf4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d078dbc-73ca-0868-71f8-16e413ebdbf4@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 08:14:25AM -0700, Dave Hansen wrote:
> On 10/4/19 7:59 AM, Andy Lutomirski wrote:
> >> @@ -123,7 +125,8 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
> >>                                   unsigned long error_code,
> >>                                   unsigned long fault_addr)
> >>  {
> >> -       WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
> >> +       WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault at %s address in user access.",
> >> +                 is_canonical_addr(fault_addr) ? "canonical" : "non-canonical");
> > Unless the hardware behaves rather differently from the way I think it
> > does, fault_addr is garbage for anything other than #PF and sometimes
> > for #DF.  (And maybe the virtualization faults?)  I don't believe that
> > #GP fills in CR2.
> 
> For #GP, we do:
> 
> do_general_protection(struct pt_regs *regs, long error_code)
> {
> ...
>         if (!user_mode(regs)) {
>                 if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
>                         return;
> 
> Where the 0 is 'fault_addr'.  I'm not sure any other way that
> ex_handler_uaccess() can get called with trapnr == X86_TRAP_GP.  0 is
> canonical last I checked, which would make this patch a bit academic. :)
My fault. I thought the 'fault_addr' is filled with a valid value. So we really
don't know the answer without decoding the instruction which causes this #GP. :)

-- 
Cheers,
Changbin Du
