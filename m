Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D241C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7D02166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grvOSvfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfHIWVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:21:44 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38177 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHIWVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:21:44 -0400
Received: by mail-pg1-f181.google.com with SMTP id z14so9277187pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Ac5KXZIanCVTJN/HjuW15OBDL5Fr06R3VXRoaZc/Zgs=;
        b=grvOSvfc08cBG3dmx/ZPZ0a2qGjLub5QY3pEZGgAuVKYtbCU5Z8NBTXPP7CbbGdKMr
         1twndSwfVKoVRlkTd2QvuqCHddBueCsrQw/l2Ao/fVQDW7/xCR6ghxuUhXIxS5eVAGdp
         boC3yAo43yVwxwYUBbK7UTCC3++JdrOcO0CTrs4WGoUliXAHmZsTqqzkz9+vLXOcb/My
         onQ9gvdqcHDlxwLWOvvgKv3LW59OFOma84FMHvC9uWC058Ei7Ct6L0SNugZCgOy9hgfT
         feVt4wZjKOBjnrbGHfjKLYrWW1fIaFRo6rNJLHnAK6V1p9S8ogGzWi1YabFA1uZwb74n
         dEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Ac5KXZIanCVTJN/HjuW15OBDL5Fr06R3VXRoaZc/Zgs=;
        b=mZCwDoOGazlzl/bHQpFjs7ok4LinRP7d10xfsNjfjJTwvW8Ibnli9noQxbQwFoXkG/
         bWUhFQ4nzymYs94vxZ6NIvlz9L/vjipwwwvex0RHyjseyJyi5BJLd+0wENL+r8Rptjsb
         dvuiR+mmtm0+8lifc7Hagw11DT7WQAGOoOHWVaATNyLsi4YivSBfz57RYmZa9v7nyFzH
         ru2xckGXxuFdTF9x9q9EcdhoV9r98gaJSEqyo26uRVUGWnUa8qRnfdde9azx1ECNG1td
         /DNz45sqhLVkYBlg2jBNMir4c/evTS4dfDjFn+Dhs2lzaDc7z63JsDAYSb3hAhNsMlRQ
         GuLg==
X-Gm-Message-State: APjAAAW6V423s3tLoUoO4qBG3USLmFsqCRbEvV/ZU8NYAXYb0tYpx8eO
        jaBAI5QFY+WK6nwBjgDxG99ro1bPzyoTI/IKQlWm+38ixc4a/A==
X-Google-Smtp-Source: APXvYqzH8LpGgJ5RiLI1+27K41dw6esf/Rp6wn+zLbYXDeKesLdpakOUz7cMiZPgS6n3aLXsDtT7S2OCZUQkcHpoZN8=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr5488336pjt.123.1565389303063;
 Fri, 09 Aug 2019 15:21:43 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Aug 2019 15:21:31 -0700
Message-ID: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
Subject: checkpatch.pl should suggest __section
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,
While debugging:
https://github.com/ClangBuiltLinux/linux/issues/619
we found a bunch of places where __section is not used but could be,
and uses a string literal when it probably should not be.

Just a thought that maybe checkpatch.pl could warn if
`__attribute__((section` appeared in the added diff, and suggest
__section? Then further warn to not use `""` for the section name?
-- 
Thanks,
~Nick Desaulniers
