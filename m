Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C78C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCE82133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrdKyJkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfCSRvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:51:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34582 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfCSRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:51:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id a16so17393855edn.1;
        Tue, 19 Mar 2019 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZO+ZwteIH+GN4tz9mx+I/xS7VS60SBHJoatRPiKCAhA=;
        b=GrdKyJkS7Z5/5sccKgmn0an8u7nSZHCACOQalJ/giU9wpaS71yxBZRuuBXHlhzTJxp
         T4diMEqn6dyMshOWc+OhBeGNJnMvAuepPJcMSrvJunb6TpERV8LO3lgaVevg8eXGGYpb
         XhgsWytdhZNzhMlCFuLuYxk+wdYROA4KF6yLJSg3b/rfUNxBfA40PN2qdc6tt8qy/SwV
         Uwrly9tQIXh9fmf7VGjZOn0mEC0PKSgcybsoYr+aV8w5oPsRXJnw5bEaziruHnwhbtF8
         k4G64WavznRIIe4xRxGANlWjPAET1pPC1BCHuCe/b6tpBhDVoSqu2GhqATzguXbtdG71
         ZG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZO+ZwteIH+GN4tz9mx+I/xS7VS60SBHJoatRPiKCAhA=;
        b=YQKMRwPrKSyHSOijK00FFzBJjCStSTcF5Hz6LKiVB9I7dAmBpVZ/RnxB1Ipr/5Ahxx
         AYJBRCfJnD/M2ENe8AQkMCfyjyeValVCxjl3lCF/McdSb/4jQ90HElSRqC1+Kx8IxtIU
         dppvVKRiqpnYpS1cVpObOphHOH6wyTsb6dFeV8/R+4OnbgSjnvmElrrUKo1BFtoqJKKz
         /uQW2gnIqe5TukcC0Xghc5zns3y0fgZeR6v6IqS/5U6SZjuA1Vp3tZIXI/TOoT0yfGgo
         Y+7mKm64mwemKjE72PN0Eg1Od+ugZuhWNCmHfXDXE25d/xl1wJNKKZXTEdSdDyQ2RXiX
         qWfw==
X-Gm-Message-State: APjAAAWdY40aECRZ5kYusBtppgYlPOOAB/w0NrTuUa8qDIKQ+n+J7B1v
        5PwV4VZPbJZunwpdxVn1KXKVx9VH
X-Google-Smtp-Source: APXvYqzKWM8caSHFb5XhB9hERoHdRy158DJujuJrWp2otQRhqD/H1tqDYwsgJ3+6lDuuTHqmKTXGwg==
X-Received: by 2002:aa7:dd0e:: with SMTP id i14mr1409148edv.172.1553017871345;
        Tue, 19 Mar 2019 10:51:11 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4049:a600:52:6fcd:af3b:582e])
        by smtp.gmail.com with ESMTPSA id w8sm3238240ejj.27.2019.03.19.10.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:51:10 -0700 (PDT)
Date:   Tue, 19 Mar 2019 18:51:08 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] include/linux/hugetlb.h: Convert to use vm_fault_t
Message-ID: <20190319175107.oxwjf72hpcqqmo3l@ltop.local>
References: <20190318162604.GA31553@jordon-HP-15-Notebook-PC>
 <20190319032022.GR19508@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319032022.GR19508@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 08:20:22PM -0700, Matthew Wilcox wrote:
> On Mon, Mar 18, 2019 at 09:56:05PM +0530, Souptick Joarder wrote:
> > >> mm/memory.c:3968:21: sparse: incorrect type in assignment (different
> > >> base types) @@    expected restricted vm_fault_t [usertype] ret @@
> > >> got e] ret @@
> >    mm/memory.c:3968:21:    expected restricted vm_fault_t [usertype] ret
> >    mm/memory.c:3968:21:    got int
> 
> I think this may be a sparse bug.
> 
> Compare:
> 
> +++ b/mm/memory.c
> @@ -3964,6 +3964,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>         if (flags & FAULT_FLAG_USER)
>                 mem_cgroup_enter_user_fault();
>  
> +       ret = 0;
> +       ret = ({ BUG(); 0; });
> +       ret = 1;
>         if (unlikely(is_vm_hugetlb_page(vma)))
>                 ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
>         else
> 
> ../mm/memory.c:3968:13: sparse: warning: incorrect type in assignment (different base types)
> ../mm/memory.c:3968:13: sparse:    expected restricted vm_fault_t [assigned] [usertype] ret
> ../mm/memory.c:3968:13: sparse:    got int
> ../mm/memory.c:3969:13: sparse: warning: incorrect type in assignment (different base types)
> ../mm/memory.c:3969:13: sparse:    expected restricted vm_fault_t [assigned] [usertype] ret
> ../mm/memory.c:3969:13: sparse:    got int
> 
> vm_fault_t is __bitwise:
> 
> include/linux/mm_types.h:typedef __bitwise unsigned int vm_fault_t;
> 
> so simply assigning 0 to ret should work (and does on line 3967), but
> sparse doesn't seem to like it as part of a ({ .. }) expression.

This is the expected behaviour. The constant 0 is magic regarding
bitwise types but ({ ...; 0; }) is not, it is just an ordinary expression
of type 'int'.

So, IMHO, Souptick's patch is the right thing to do.


Best regards,
-- Luc Van Oostenryck
