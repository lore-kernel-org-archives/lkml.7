Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01156C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C469E206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvOr4Sp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfFTVhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:37:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45431 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfFTVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:37:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so6711594edv.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=v3IpD3zOAyT/o3jFLveqYdHxVLapPS/YFt6LidFqVKU=;
        b=KvOr4Sp+Id3A6XKZfDq0jaToh9hTpDvR4uHERHTmM5jYRInzJr41kiC9SoOmmDJhky
         oWXqPY/lKaIz9THmlD7IH7YFcmC3tZDq/MG8PgXKGCf9XHFgOdbfcOfRn1VFfw/TeOoP
         bFK/Xo6W9HJHbqyCJAlgYtMGuDNKG7dFjc43Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=v3IpD3zOAyT/o3jFLveqYdHxVLapPS/YFt6LidFqVKU=;
        b=U79vuhi7R8u4ri0CyVV3uWJB1hZBet/VhMRZ3ZzXNSD5cKb0X32dlnbmryl1je0MWS
         aMtPDQISUAVN0w4nxsv+1JVeIdSiKRg3T609FkSZu+sjKkUuDKkV2fDFWeXNp5JBAkNG
         lFZ1umsbgi5lHtNJVv9tLaz1dmYjtHhSsX6U5tsYd0bV1DtDUFrj9BJ0nkxhoo84eXPf
         De76Dbe86z/rmE/1PnJ0UExjgleRHE6wq2FBxUj6WGeIup9Fb1L1B0EWHfFmWcc9pkvy
         m89ysbTMfx+UMGmX0bY4p3fcTZZege2IpSgbOf7v3W0wFW9jIt+c8zSG47ZTmg6HsmsJ
         /fMA==
X-Gm-Message-State: APjAAAX8abUT2+z96UcnG/3+iFHg9lMlOXJuYsc+iEbuqdyTgRdjuzpS
        nbdH4ripWCyi0wXLpfHg343xGRmTuJs=
X-Google-Smtp-Source: APXvYqwvR/hMYD3xrgS9iC4wgSKZzeekpDjgwXzHCyOHlapnUcWRMSvlntMdrtQE2IYJlwCdGWYEtw==
X-Received: by 2002:a50:f5f5:: with SMTP id x50mr55771854edm.89.1561066621050;
        Thu, 20 Jun 2019 14:37:01 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id m19sm86599eje.30.2019.06.20.14.37.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:37:00 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id m10so6778858edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 14:37:00 -0700 (PDT)
X-Received: by 2002:a17:906:b315:: with SMTP id n21mr8174762ejz.312.1561066175899;
 Thu, 20 Jun 2019 14:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190620151839.195506-1-zwisler@google.com> <20190620151839.195506-3-zwisler@google.com>
 <20190620212517.GC4650@mit.edu>
In-Reply-To: <20190620212517.GC4650@mit.edu>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Thu, 20 Jun 2019 15:29:24 -0600
X-Gmail-Original-Message-ID: <CAGRrVHw8LuMT7eTnJ4VV9OpnetSSYaLh5nLkN4Anevz6r8KmZA@mail.gmail.com>
Message-ID: <CAGRrVHw8LuMT7eTnJ4VV9OpnetSSYaLh5nLkN4Anevz6r8KmZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] jbd2: introduce jbd2_inode dirty range scoping
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Ross Zwisler <zwisler@chromium.org>,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 3:25 PM Theodore Ts'o <tytso@mit.edu> wrote:
> On Thu, Jun 20, 2019 at 09:18:38AM -0600, Ross Zwisler wrote:
> > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > index 5c04181b7c6d8..0e0393e7f41a4 100644
> > --- a/include/linux/jbd2.h
> > +++ b/include/linux/jbd2.h
> > @@ -1397,6 +1413,12 @@ extern int        jbd2_journal_force_commit(journal_t *);
> >  extern int      jbd2_journal_force_commit_nested(journal_t *);
> >  extern int      jbd2_journal_inode_add_write(handle_t *handle, struct jbd2_inode *inode);
> >  extern int      jbd2_journal_inode_add_wait(handle_t *handle, struct jbd2_inode *inode);
> > +extern int      jbd2_journal_inode_ranged_write(handle_t *handle,
> > +                     struct jbd2_inode *inode, loff_t start_byte,
> > +                     loff_t length);
> > +extern int      jbd2_journal_inode_ranged_wait(handle_t *handle,
> > +                     struct jbd2_inode *inode, loff_t start_byte,
> > +                     loff_t length);
> >  extern int      jbd2_journal_begin_ordered_truncate(journal_t *journal,
> >                               struct jbd2_inode *inode, loff_t new_size);
> >  extern void     jbd2_journal_init_jbd_inode(struct jbd2_inode *jinode, struct inode *inode);
>
> You're adding two new functions that are called from outside the jbd2
> subsystem.  To support compiling jbd2 as a module, we also need to add
> EXPORT_SYMBOL declarations for these two functions.
>
> I'll take care of this when applying this change.

Ah, yep, great catch.  Thanks!
