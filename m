Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F05EC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0218C218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8vpjBx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfGCAiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:38:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37834 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfGCAiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:38:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so576969oih.4;
        Tue, 02 Jul 2019 17:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aBBXhrXh9/4XOgm4YO50PZ7nN7ZBQawsgLFlMkXEs1w=;
        b=V8vpjBx1kzZa2mv6jb/tVkHvFf0jcI4WTGGOotiqRdxM+1C9MhPEoVjM//rJbTykNo
         ldSHgjY7uLogQ7N/1qWi31GeqMrPakJSE4e8mxx2PbQDlFu5D0M6I4WGF9MqRzajhdNz
         +KXHG7yOnR8KHMDh1bRb7sAsONTXUjJn5E1iqJ3iAcXDgD5YjndFxyIznXMYfpJVweNs
         l2jtSDIAkS/QZN5SPFRbaGQ3ZSokN7GLUrSlLYFjvCNbBt6iPaxD6ifqNqjvu4JDZ0a8
         S4lkXFKFRQPgnzslQNCbtAx9fC4spPYhRk8nz3b1smN8oOf9QKengOCpV/VQJYI8MgF3
         h7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aBBXhrXh9/4XOgm4YO50PZ7nN7ZBQawsgLFlMkXEs1w=;
        b=szJ+5hF/VfKsNPJAj1FLvqiTo65IE1ulqSdRvG7Qv5WuVFqgCP8ecc9sjeQbKoK7np
         aLbaQguE138IYJNWuZ0btmRYwnNrJWByjplvckiNbgmYJQV3GpRV97V/ubFu0H/H6x5h
         +zCKEx/uNwNwdtNcKhmAmUWfvQe2MgCJVdMg1LowheJlnF+w3aLci88ykNsTYhFBn0nN
         8hdllgVByowa5yK8hvRHNwZLCqmvn42ylDL7LHiGVk62PNPLHrUEi/4TT7Yx31FoM5YH
         pv95nG+alEmu95y8xv5bL1Sh5eJhW+541p9Wm6e6RFGfMs3JLtYjEKnTuKg6vg9ald8a
         4G4g==
X-Gm-Message-State: APjAAAXi+syjNNXyjDb5IyBsiHgLmlr8qJdvgYsXKyIVRom0Wv/XBbOH
        xioi0H7dDOSZUaoEbsqV3k7udCp31CY=
X-Google-Smtp-Source: APXvYqwnTjoGdkjeDwZ2laVOlEN4b75Fj9Qb/yLUyGM1yb/F0z2LXav1KxBP0foWkEJJqVcDI1V4lw==
X-Received: by 2002:a63:f14:: with SMTP id e20mr33320739pgl.227.1562108916478;
        Tue, 02 Jul 2019 16:08:36 -0700 (PDT)
Received: from continental ([189.58.144.164])
        by smtp.gmail.com with ESMTPSA id 2sm129227pff.174.2019.07.02.16.08.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 16:08:35 -0700 (PDT)
Date:   Tue, 2 Jul 2019 20:09:19 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH 1/2] scsi: devinfo: BLIST_TRY_VPD_PAGES for SanDisk
 Cruzer Blade
Message-ID: <20190702230919.GB19791@continental>
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
 <20190618013146.21961-2-marcos.souza.org@gmail.com>
 <yq1r27quuod.fsf@oracle.com>
 <20190619094540.GA26980@continental>
 <20190619120346.GC26980@continental>
 <yq14l4kro9l.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq14l4kro9l.fsf@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 04:32:38PM -0400, Martin K. Petersen wrote:
> 
> Marcos,
> 
> > My first idea was to add a vendor:product mapping at SCSI layer, but
> > so far I haven't found one, so I added the model/vendor found by
> > INQUIRY. Would it be better to check for prod:vendor (as values,
> > instead of the description)?
> 
> Your patch is functionally fine. I'm just trying to establish how risky
> it is for me to pick it up.

I've tried to find any official document about Cruzer Blade devices, stating
that all of them have at least SPC-3 to support VPD, but no luck so far :(

So feel free to ignore the patch if you think it's too risky.

Thanks,
Marcos

> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering
