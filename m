Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D735EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B5D2071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573749295;
	bh=dNceW5/2JIbHCI0Ab/8muEpZcy/gU6c3yG9FqORKNOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gxnWZsyOcN5kyGOj0DBrq+HohNwQcLA5Az4/TMYRS91Apm9zlKwLbvcM3n0z67fDl
	 4oNiIFKNKy3GP5UBP62bHDiQj/zvuyjNJZRc0u0w9B4eE+fz/kSVr4kIi6Qa267ccQ
	 q6SGsXXzEWgYKwYbj+4RWI76se4MdkT21Kbrro2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKNQey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfKNQew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:34:52 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 632B320724;
        Thu, 14 Nov 2019 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573749292;
        bh=dNceW5/2JIbHCI0Ab/8muEpZcy/gU6c3yG9FqORKNOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0rrnp7YLb6ZW4Wh2jc3TY9uHPIUVLMaVk8Z6uNAziRS0qjzG0DNjonzB/VudcnhtE
         Jrif7/VoFnAiECjZiYWl89pH3a1eFwr3k+Oo9/Ej5ArHz3klfrQqQAiRT6kefSZMOZ
         n/dTrdQ+PjObIrMhU5/d0AJBI8zZV014QOmUl7fQ=
Received: by mail-qk1-f173.google.com with SMTP id m4so5493860qke.9;
        Thu, 14 Nov 2019 08:34:52 -0800 (PST)
X-Gm-Message-State: APjAAAUWBYGuaBFvWoRYiDCqO0SwAX/16mMYd7OOwDMCtwSchi3G4gJL
        PhS/P4VnzE9bdn+gwf3mEeMth/vUfcoa2xot+Q==
X-Google-Smtp-Source: APXvYqyTT89qPyhwQ8HbCne8V44sYkR4vJwSLLq3suXRCO5HAxlj6sw4/AVmK4gepiW4WN6VNuNgbAUjWTH0DnkbUlg=
X-Received: by 2002:a37:4904:: with SMTP id w4mr7612533qka.119.1573749291482;
 Thu, 14 Nov 2019 08:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20191113210544.1894-1-robh@kernel.org> <30b73f89-1ba1-6052-53bd-414ebdfa142c@codeaurora.org>
In-Reply-To: <30b73f89-1ba1-6052-53bd-414ebdfa142c@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Nov 2019 10:34:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+WFvwBy4rpZkT=_KMYzzvrsLcaTMFSydY_euuFLAsZEQ@mail.gmail.com>
Message-ID: <CAL_Jsq+WFvwBy4rpZkT=_KMYzzvrsLcaTMFSydY_euuFLAsZEQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Improve validation build error handling
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 9:21 AM Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>
> On 11/13/2019 2:05 PM, Rob Herring wrote:
> > Schema errors can cause make to exit before useful information is
> > printed. This leaves developers wondering what's wrong. It can be
> > overcome passing '-k' to make, but that's not an obvious solution.
> > There's 2 scenarios where this happens.
> >
> > When using DT_SCHEMA_FILES to validate with a single schema, any error
> > in the schema results in processed-schema.yaml being empty causing a
> > make error. The result is the specific errors in the schema are never
> > shown because processed-schema.yaml is the first target built. Simply
> > making processed-schema.yaml last in extra-y ensures the full schema
> > validation with detailed error messages happen first.
> >
> > The 2nd problem is while schema errors are ignored for
> > processed-schema.yaml, full validation of the schema still runs in
> > parallel and any schema validation errors will still stop the build when
> > running validation of dts files. The fix is to not add the schema
> > examples to extra-y in this case. This means 'dtbs_check' is no longer a
> > superset of 'dt_binding_check'. Update the documentation to make this
> > clear.
> >
> > Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> I injected a syntax error into a random binding file, and compared the
> output with and without this patch.  This patch makes a massive
> improvement in giving the user the necessary information to identify and
> fix issues.  Thanks!

BTW, update dtschema and you'll get better (or more at least) messages
when 'is not valid under any of the given schemas' errors occur.

> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

Thanks.

Rob
