Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8779CC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E09F204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prPrOvv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfESRaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:30:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43031 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfESRaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:30:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn7so1441079plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3nXBmIh7/vFkJ4Tm2l4dtTScuooDKNvEF1jpFXfvwsc=;
        b=prPrOvv+nXzlq37dw9S0qdmegNQMY9mMQmGxVdosiPQlKvmQHZwzyNNaISmaHYISPL
         X+MnJT//NcQ21npBKca3WpAApauj41TAIoPfE8Yn1PKHUg9dRm+3twylCz1VcUhpj9AY
         TcBLFLBaEYI9qMBT/BXar0olvQLimM1sWud1T1/GfOO13CqMdqbUwAOF6akeVMHvShBG
         389EvyUF/W8ChWuTLWfKobvsEmxcppXOOvx5AbluLHXBrSxVUDsPtbnSGtuNc47AipJP
         LrRYAfePFA7lz8yV6lvkrbyhb38/XY3u7Pi4ItdkOP+VRZUORZzNtLVvNvBwQHUVJgbK
         jkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3nXBmIh7/vFkJ4Tm2l4dtTScuooDKNvEF1jpFXfvwsc=;
        b=R+jVfNpSHDcdY7aT9vJ1878WuMHrDX4OWUdb6plfP+2TDQ7+u7u+E/axbDuKEnV9SX
         9KbStvbn3Z+c1MAWyVhjV+eS92vAnQCsTRaAuuQhUFy8BeeP9z90ge4Tko8XIRtHs9WU
         l7eZ+9nWNmTRV56Y51extDtVhN8KpygiKCxozOGqgOBqLhi3t4XQNYDNhZTY4YhLXEzu
         oLTMwEcjTKJ+cVeFAogm6AESDHav3kwM2VJEaKGtEj6kpPKInGwhZZ+ymBW2aWP5l8Le
         ncLftjB4fskQ0JCpoDx1MVC9n16vNGOBXJajaq9ERARtxGA52umn5QfkZJgrHPEIb3xQ
         QWjg==
X-Gm-Message-State: APjAAAUgHDBYV5C8zbqiAjyW/7qrtHHpAsdHvL6co3ZlxUsUNVtj9hJg
        x9CfKydRXHR1WZX6OR25eW6jb57s
X-Google-Smtp-Source: APXvYqxWU8wpTJXHBJp+Rkhz1pg1a0Wph4MXE9asWBt0UGUSJ69BeobNf1W2Emh5hysyAcKSb/AXeQ==
X-Received: by 2002:a17:902:204:: with SMTP id 4mr17066355plc.21.1558260698892;
        Sun, 19 May 2019 03:11:38 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id c17sm9740268pfo.114.2019.05.19.03.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 03:11:38 -0700 (PDT)
Date:   Sun, 19 May 2019 15:41:32 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Gao Xiang <hsiangkao@aol.com>, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] staging: erofs: fix Warning Use BUG_ON instead of if
 condition followed by BUG
Message-ID: <20190519101132.GA22620@hari-Inspiron-1545>
References: <20190519093440.GA16838@hari-Inspiron-1545>
 <b32e6bca-60ec-2004-f1d6-16d2b8a478ae@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b32e6bca-60ec-2004-f1d6-16d2b8a478ae@aol.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 05:50:40PM +0800, Gao Xiang wrote:
> 
> 
> On 2019/5/19 下午5:34, Hariprasad Kelam wrote:
> > fix below warning reported by  coccicheck
> > 
> > drivers/staging/erofs/unzip_pagevec.h:74:2-5: WARNING: Use BUG_ON
> > instead of if condition followed by BUG.
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > -----
> > Changes in v2:
> >   - replace BUG_ON with  DBG_BUGON
> > -----
> > ---
> >  drivers/staging/erofs/unzip_pagevec.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
> > index f37d8fd..7938ee3 100644
> > --- a/drivers/staging/erofs/unzip_pagevec.h
> > +++ b/drivers/staging/erofs/unzip_pagevec.h
> > @@ -70,8 +70,7 @@ z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
> >  			return tagptr_unfold_ptr(t);
> >  	}
> >  
> 
> I'd like to delete this line
> 
> > -	if (unlikely(nr >= ctor->nr))
> > -		BUG();
> > +	DBG_BUGON(nr >= ctor->nr);
> >  
> 
> and this line.. I have already sent a new patch based on your v1 patch,
> could you please check it out if it is acceptable for you? :)
> 
> Thanks,
> Gao Xiang

Hi Gai Xiang,

The patch which you sent has all required. 
Thanks for the  patch. We can ignore this v2 patch.

Thanks,
Hariprasad k



> >  	return NULL;
> >  }
> > 
