Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D08C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C88B206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czw/6PNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfGBDIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:08:01 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:43393 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBDIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:08:00 -0400
Received: by mail-qt1-f179.google.com with SMTP id w17so16947007qto.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 20:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fs6kSj1lNlmKFFkvCv71QG06kU56DRX1KEDeflpwLYI=;
        b=Czw/6PNRt00suUoSDwDgGLWSmebXwYGLWPcd80ETgUef3ImGJ3OH8VCl4CqcSE1ZkX
         3RWzHUj4VqjzvcVQ1JZq1/fGigmNZcwB2e5iQqcTLQeC26EoagVJ2KrgfBYx8GvfTrkz
         Go+dybA6beOjC8SOTAR3ACuSOa77RwaOyZ43goEGTMZki9bc8N+AsiNxUJrjIT5t9bdK
         qI+dfU3FFopktlg3WhVqvWxsPEdcIPh9uVwb/aA6Ndh0Xi/t2KepGU/qI7Q84jH/NUgV
         DIf1Dn5VJORFYu3+yPFGRxkoHSMe9M44BZaRpqRhZfRPRZbYib0L0UmVslNLmei5F1RP
         sq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fs6kSj1lNlmKFFkvCv71QG06kU56DRX1KEDeflpwLYI=;
        b=WfxRjy2RxFMFLYXrVCv9U6acbz18ykEl63r1MGqYj4hOmFDRXWvxBjz13fVYfAY20X
         m95x1s0n2mggFSirkHAhoGou4hUTR7cNEw3miEuDhC0j+Wapq0YSQAigsNuXLl3a/hdE
         ELwvjUB7/4TxhWAIiCCjak6yxTpPe7XpPCjfQKb+gmuiuVbn0PBQhgCetzT3glI9Yqxg
         N8r0Z99Ufe8o79jmt+XInOk0GFOFaioKfin8t8RcAYqqHeshSU/jJpE/6W1kO0wDOJKd
         oESt3JCcELHP2YZ3PhrVcAw2kLLwWoc+lE5qyxx7UdqPFfSLwvsegq+ZY6GSt+lwOb7g
         PtIw==
X-Gm-Message-State: APjAAAVEBUswh8UgkRQL1kPife7Ph5pVSG7g12+W/On9BG6xMBUG6jqA
        yRzzTRos2cSinnBKXOC+dFI8FjX5oNfCw/fZBkA=
X-Google-Smtp-Source: APXvYqxfm6Gx0NLdFETsNgAYf8sENF7urll000uasTu6sH+Ll7aywhKr5PZMwpYL86aYbFGFFpy7fgljHWErOEls57g=
X-Received: by 2002:ac8:2b90:: with SMTP id m16mr22999292qtm.384.1562036880016;
 Mon, 01 Jul 2019 20:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000106b11058ca6f7f2@google.com> <38d777292f5335b5ea5f8fd7c0b58c514dda525a.camel@kernel.crashing.org>
In-Reply-To: <38d777292f5335b5ea5f8fd7c0b58c514dda525a.camel@kernel.crashing.org>
From:   Muchun Song <smuchun@gmail.com>
Date:   Tue, 2 Jul 2019 11:07:48 +0800
Message-ID: <CAPSr9jHf3JGSPCFY2aF7fPELrcKfkeWR3hsT-nFzjpZNw8XqWg@mail.gmail.com>
Subject: Re: WARNING: refcount bug in kobject_add_internal
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Benjamin Herrenschmidt <benh@kernel.crashing.org> =E4=BA=8E2019=E5=B9=B47=
=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:44=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Munchun, is this what your patch fixes ?
>
 Yes, this is what my patch fixes.

The patchs can reference to:
        [PATCH v1 OPT1] driver core: Fix use-after-free and double
free on glue directory
        [PATCH v4 OPT2] driver core: Fix use-after-free and double
free on glue directory

And waiting for Greg chose which solution he prefered.

Yours,
Muchun
