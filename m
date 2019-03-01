Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41292C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEF720663
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbfCAJs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:48:57 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38216 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfCAJs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:48:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id s1so27017565qte.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 01:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LMNpLvh0zm8uQU5AuR96ebWw0dHa31YuIeyCU0Dmjg=;
        b=NCIAKu0/CdL0D5Jaz9pnv/YRd9UB2SqgE6XDTim1or9vlM8r7w9VqGUhhog7RXu5mZ
         K3FQ2ZttH/C4Mqbb31e8rNtRv0IuqLYobM6K82BiHGRYy9R1NYgopi7cyLagwrW9hraF
         fngQVAVvZPPmYSjjFsMspBvuaDBR6iEhPoGRkBwUrayNrdCD+fcsu1+oUp91xLVvUsyM
         Te+hXqdWQ1q2cpU73aC5/DBSeLR/iwJkZwT5/rrsuuCKIlOIzj/ZMk2ttPwcamB++0Mv
         yn136v9jQ6erSgCPJUrqxeFFFWZE0ACD/i55JLKM0FiFuqmprj3ELIRMuioS/+M7foU6
         rnig==
X-Gm-Message-State: APjAAAV0i34WtRM/M4TIpRFSoy+vXD0auUMQ91o6Aw7KER7k2/ndNKd3
        L4fb0EtMEmMcKWUuj+OUWOukkMllbU4s6JJJpI6k8A==
X-Google-Smtp-Source: APXvYqxQKTiGk6OKhXB7jnlcsSPDZN0IRBKw7oiQgraxSeHnnirOn5LuPCCqJdpLJkIsc1rv2UVUnICsIbxkuMPDxpI=
X-Received: by 2002:a0c:d13c:: with SMTP id a57mr3080086qvh.192.1551433735754;
 Fri, 01 Mar 2019 01:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20190228135556.14713-1-nsaenzjulienne@suse.de>
 <BYAPR02MB56078ADD429292DF89F8C694ED750@BYAPR02MB5607.namprd02.prod.outlook.com>
 <a6ecd59f99aa64355ac7c176aa4310d32ce8969e.camel@suse.de>
In-Reply-To: <a6ecd59f99aa64355ac7c176aa4310d32ce8969e.camel@suse.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 1 Mar 2019 10:48:44 +0100
Message-ID: <CAO-hwJ+9ft070W-shhEwxfTq9B5XyVB2v6Qx0b4nC4LdTiTEDg@mail.gmail.com>
Subject: Re: [RFC/RFT] HID: primax: Fix wireless keyboards descriptor
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     "Junge, Terry" <Terry.Junge@plantronics.com>,
        Jiri Kosina <jikos@kernel.org>,
        "oneukum@suse.de" <oneukum@suse.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 7:01 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Thu, 2019-02-28 at 17:02 +0000, Junge, Terry wrote:
> > This could also be a parser error. In the HID specification section 6.2.2.8 it
> > states that the last declared Usage Page is applied to Usages when the Main
> > item is encountered.
> >
> > "If the bSize field = 1 or 2 then the Usage is interpreted as an unsigned
> > value
> > that selects a Usage ID on the currently defined Usage Page. When the parser
> > encounters a main item it concatenates the last declared Usage Page with a
> > Usage to form a complete usage value. Extended usages can be used to
> > override the currently defined Usage Page for individual usages."
> >
>
> Hi Terry, thanks for the comment.
> Just for the record the paragraph I cited on my patch is the following:
>
>         6.2.2.7 Global Items
>
>         [...]
>
>         Usage Page: Unsigned integer specifying the current Usage Page. Since a
>         usage are 32 bit values, Usage Page items can be used to conserve space
>         in a report descriptor by setting the high order 16 bits of a
>         subsequent usages. Any usage that follows which is defines* 16 bits or
>         less is interpreted as a Usage ID and concatenated with the Usage Page
>         to form a 32 bit Usage.
>
>         * This is a spec errata, I belive it should say "defined"
>
> As you can see they use the word "follows" which in my opinion contradicts the
> paragraph you pointed out. That said I may be wrong, I'm not too good at
> reading specs :).

I think you are both right (that is some decision making skills :-P).

I never saw a case where the Usage Page was after the Usage. And I
would lean towards Nicolas interpretation.
However, Terry's point is valid too, and by re-reading the two
paragraphs, one could argue that the "follows" of 6.2.2.7 could be
applied when the Main item is processed as in 6.2.2.8.

So I am going to base my decision on the "reference" driver. How well
behaves Windows with this particular keyboard?

If it behaves properly, then we better use the 6.2.2.8 version where
the Usage Page is only appended when there is a Main item. This means
we need to remember what size was the last Usage (and Min/Max), to
know if we should concatenate the 2.

Note that for every change that involves the generic parser, I'd like
a few tests added to `tests/test_keyboard.py in
https://gitlab.freedesktop.org/libevdev/hid-tools
Also note that the HID parser implementation in hid-tools follows the
kernel, so we might need to adjust it there too if we want to add high
level events. If you directly call `.call_input_event()` with raw
events, it should be fine.

>
> I checked the HID parser and it's indeed written assuming local items are
> preceded by a Usage Page. I'd be glad to fix it there, but it would be nice to
> have the mantainer's opinion on the matter first.
>

You've now got the opinion of one of the 2 maintainers, hope this helps :)

Cheers,
Benjamin
