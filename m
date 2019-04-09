Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A636C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9EB20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSaOFaBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDIPSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:18:25 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37552 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfDIPSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:18:25 -0400
Received: by mail-vs1-f67.google.com with SMTP id w13so10033488vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhyeJ15FAJPTr9rEUZIVrKa7R7TUukl7rnxAn28a2gM=;
        b=pSaOFaBcsl6wclKVgvX4+9zZ5q/Psjw6n7qweesHno3aCVtd/ENDBaMnQOWb1UtP/+
         4CAe6Q5kG0F83kd2fWdkMiyO7o1FWmKK+Awa206ceOp1Bk87dO0s3xRf+fzL/8t5UMDA
         oqOm7jlHLV5Ad6aeEF8mfAp9rm3Atc3SQHwj3aJ9MMWF9tFJKu/fBUBjekfWvhcyKw3N
         usxSKnPXhZBaEovKxCOhT/Li/WSupWet3ohbqRgerEOYfFtM8SrOIm57HbTWHLQs8ZyE
         x0uyNXe38t/4REw32Jjlyzx5kzrGX6BY91o83toORzxr33S7JQ6jVDmRp00F/W7sOHha
         pwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhyeJ15FAJPTr9rEUZIVrKa7R7TUukl7rnxAn28a2gM=;
        b=L02/tGTxZSfLoljJ9ePJ8fplmVbfrTxwutKWhxhYQfdlC8gdIzHAzKMdmjbou0i49/
         8iDozTOPSSJ/LD8BsA1dT3fLglPHOeVvM3AZzt5CK4HuG69VCSGIfajm8m0SIGs63pWF
         e3MHgvI/2xUyaHLePhuPCBZPEz2MBb5rvHnUadp9X7/fQhH2TKqJDwpTMYPfKY2qWa/z
         Qcj+8Uj9TrDRSKpSYbLRmrW0gdSwEOk1vVxGnzXHbNl/1Crx3+OlF7QmLa6SaE38QPyh
         XPS4O7gLy+k6ee4FpdhdtQgxC1VkITisLTsWrqpIdhl9Zk4W/iEzgyu9ssOLNQbSlaSl
         zVvA==
X-Gm-Message-State: APjAAAW3Jvmxx2eWvpotgRKRqLamkRnxPf9M5ZPD8t8n1tlKVTET8YTD
        VASmhgJ580WPb01jTcMBzkqVDlbC/v5ECg5nBG8mjL57
X-Google-Smtp-Source: APXvYqzXiRJsDsxzJ1yFYM4quvCwcZqppLdc9+u0aho6BRgFrTN7Uhe7jcf0mADZbxvChpYdHU1GXGy/AAhuNz+A8fo=
X-Received: by 2002:a67:f04e:: with SMTP id q14mr20834202vsm.133.1554823104356;
 Tue, 09 Apr 2019 08:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190110220245.GA20942@embeddedor> <CAGXu5j+WYMbVaAWETjjg6BbVGNYaJt_8cKcFkiL7XUwbQEZGAA@mail.gmail.com>
 <2077.1554802104@warthog.procyon.org.uk>
In-Reply-To: <2077.1554802104@warthog.procyon.org.uk>
From:   Kees Cook <keescook@google.com>
Date:   Tue, 9 Apr 2019 08:18:13 -0700
Message-ID: <CAGXu5jJRNUZcCyRS_xXG-XYWVLkCtV1h62-H3OsQWKB4jQ02kQ@mail.gmail.com>
Subject: Re: [PATCH] afs: Mark expected switch fall-throughs
To:     David Howells <dhowells@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 2:28 AM David Howells <dhowells@redhat.com> wrote:
> Kees Cook <keescook@google.com> wrote:
>
> > These look good to me. Gets us another step to finishing this. :)
>
> Can we fix the compiler, please, to say that *every* case (perhaps barring the
> last) is expected to fall through?

Right now we're targeting both compilers and static analyzers. Neither
support this kind of marking, unfortunately. We can, however,
mechanically change this in the future if that becomes possible.

-- 
Kees Cook
