Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583D7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202E420651
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4Vn3oYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfDDUJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:09:34 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40713 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbfDDUJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:09:33 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so5812536itb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bLb+zP/1U7/cc68U8qH08JsWFZ56TbRic+4sQbf7I8=;
        b=J4Vn3oYy4osi41ATBHxrzZM/Ga2bFaA5KOI/tQ6vjxhRYLv3psN6tMIpzBKzt9wIz7
         K9OwbnPi0lJddzpaiMSGsE7jBzcYH3SYme17g8OrTsoVk4g0NW6k7qZ4Fx4Jvx8jHAtV
         AZySu2/7/sA5U5bKPxvYG/DjK/tdQFug0WjRojUhOAa0tn/QazCX5hBNr19y/PfQkbOJ
         4BRb5nTeLzljObMAC/OfavCYMJn71sT4HzqOEpQ8S9au/2Epmj7ar8o5CWfgeyUguE/j
         HRkeForAXQE+C+za6VBv8zbzbEYn29y4ep042Waa/+tz4fd9eYCQ8J2wosjx294iqzmF
         gfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bLb+zP/1U7/cc68U8qH08JsWFZ56TbRic+4sQbf7I8=;
        b=cUV6fY2vW3JXccrZinbc0vfwUXM6EuXpLFsVsIhCiuz9Ld9Q3r6w4N1CxJkSLWWVF8
         1OFkCGBINC/k04tl0cwQUARvt8mksVPfuDKSTUdz8LcQ4NLZdws7e6cuSrpc3zNFraY4
         LN0sg2JpI8NEDHcRQXYYOxSjNzMV6PCeQPphK6DZIrNnv1vp6C/iTKfhp/7EULil8P5P
         uduLXLc5y/Eiag7Jov8O3l3cPHzc/A0tYob1SxDZzqZONioz+9PbhyLmYrGoLYj1yuSe
         CIfURdCp3NLWKgqZPPNa/M1FrlGgpCDTqwONWZp5t/o7JWyp3L2KnKXF/foJu5+ORX8k
         Xyuw==
X-Gm-Message-State: APjAAAWhRhP9CPyZ+294M+Gl3IwEf4wEI58pVWM07x/Mjrb5Y5o5yH8W
        MaqUADsMEX5ZA121DCdsvWPO6aXUOwaGF3jdPO+0Rw==
X-Google-Smtp-Source: APXvYqyvaH6ScrDsGUFJtBJPfZoqCJ3a/BVA7kZPhoCuDXZFJaoKsLvOsgwu6nC/JvXmd3kVzz5Ps6fQjBa1mdCovqQ=
X-Received: by 2002:a24:3905:: with SMTP id l5mr5966372ita.43.1554408572264;
 Thu, 04 Apr 2019 13:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
 <20190404003249.14356-28-matthewgarrett@google.com> <20190404093907.153f52a8@gandalf.local.home>
In-Reply-To: <20190404093907.153f52a8@gandalf.local.home>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 4 Apr 2019 13:09:20 -0700
Message-ID: <CACdnJuurDF91MyJsngup=Xn+qShqxEqf_w1mEd7RFH5RLTWCgA@mail.gmail.com>
Subject: Re: [PATCH V32 27/27] tracefs: Restrict tracefs when the kernel is
 locked down
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 6:39 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed,  3 Apr 2019 17:32:49 -0700
> Matthew Garrett <matthewgarrett@google.com> wrote:
>
>
> > +static void tracefs_destroy_inode(struct inode *inode)
> > +{
> > +     if S_ISREG(inode->i_mode)
>
> Can we please put parenthesis around the condition. I know that the
> macro has them, but no other place in the kernel plays such a trick.

Ha, I've been spending too much time in Go lately. Fixed.
