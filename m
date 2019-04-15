Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC54C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AFA20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSPbFk1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfDOPGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:06:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34926 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOPGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:06:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so8733655pgf.2;
        Mon, 15 Apr 2019 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F2xjfvaRh0uw5y6zFsCvkgZZ7iwHwpZ25K3+/mgN9Ms=;
        b=fSPbFk1x6lW8wZs3qRwFLbSc+zwVJD+cvcjTmj+kuoWa+NofKoWlYRbxg3JwICo/3U
         ZKmb3jUgJA1HQhTaXaaua5OfKNjLuaSZNc3TTjnbaCRQXDy5vrec/iqTyOzENRs8dy+J
         /SHEHugHlctt5hDhpxAS1izERz1n0z2QwLwUYhCIKkd3OdyUiwLOpxWaIJrgf5heQ6Dv
         fS7foeUarvjg87rMbSfItPLIW4LdW4lN9JPl/kJ7V9B8yjySLndUgahhVztmhrecXjv6
         gxfp8OupZDC61ILLegtnNvrQDWPK167C5lFckxLnRY63Q6caS8R+xfF9HC9MPGtLjoBm
         8n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F2xjfvaRh0uw5y6zFsCvkgZZ7iwHwpZ25K3+/mgN9Ms=;
        b=Ju+cZ25Ya0aQhNuWOwBm/V+yKlS7zbSa8L3Yaxfbev5eww1lXBd01sQq/Kl6ndBHhh
         bKvUFZDqu5SdSiM9eCxn4tAyI32xq2ZsO3s4IJ8EswzoMgrMMAxBFwVtprTluROMWWT3
         bIBY5NiWgH0XymSOKKMstHKnYl1O+3J/SaTp1FxFDNarUBC44IisPM/MXjt3iWtcHykl
         NCN4OKZom140TV9nPBHt5isfBzUaNaKlrUAL5ZkwDDLhi/dAcdTovVUChExriNkvJfoF
         97SVf0F5yXJXf3hUdtKum5IY23s2Ve2F4EpPhrPBKF2l9T+bz4YXj6un8XQdQ6UjL+YB
         keTg==
X-Gm-Message-State: APjAAAUKo4Pcm9OyARTsTzJ5OWMLuDMuEj8izCEbKf5bZqE983CkDHVW
        MuRYKs+ITh9k1i/h0OkjBFk=
X-Google-Smtp-Source: APXvYqxamwxqzUw+rI03rNmelNO2iM2Ftwka3PUbuCdnSBefqmAA41VEYduhjY8RCr/VRMLZbzh1+w==
X-Received: by 2002:a63:7e10:: with SMTP id z16mr63796010pgc.40.1555340805630;
        Mon, 15 Apr 2019 08:06:45 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id x16sm110854069pge.27.2019.04.15.08.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 08:06:45 -0700 (PDT)
Date:   Mon, 15 Apr 2019 20:36:39 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     keescook@chromium.org, arnd@arndb.de, akpm@linux-foundation.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/reiserfs/journal.c: Make remove_journal_hash static
Message-ID: <20190415150639.GA32075@bharath12345-Inspiron-5559>
References: <20190414112438.GA23266@bharath12345-Inspiron-5559>
 <20190415094739.GA13684@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415094739.GA13684@quack2.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:47:39AM +0200, Jan Kara wrote:
> On Sun 14-04-19 16:54:38, Bharath Vedartham wrote:
> > This fixes the -WDecl sparse warning in journal.c. Function was declared
> > as static void but the definition was void.
> > 
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> 
> Thanks! I've added your patch into my tree.
>
Thanks Jan!
> 								Honza
> 
> > ---
> >  fs/reiserfs/journal.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> > index 8a76f9d..36346dc 100644
> > --- a/fs/reiserfs/journal.c
> > +++ b/fs/reiserfs/journal.c
> > @@ -1844,7 +1844,7 @@ static int flush_used_journal_lists(struct super_block *s,
> >   * removes any nodes in table with name block and dev as bh.
> >   * only touchs the hnext and hprev pointers.
> >   */
> > -void remove_journal_hash(struct super_block *sb,
> > +static void remove_journal_hash(struct super_block *sb,
> >  			 struct reiserfs_journal_cnode **table,
> >  			 struct reiserfs_journal_list *jl,
> >  			 unsigned long block, int remove_freed)
> > -- 
> > 2.7.4
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
