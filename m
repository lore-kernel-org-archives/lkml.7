Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A89C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B55206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574355511;
	bh=uYGqcM4Rx/NAAfT79RP9GtfBihFEBXrM4EFf8wvu4VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=btsz59C6E8RvX1E2GwVPTmsmMGUpV/S/1V9w1IJ4ityaOlt6mbu0+GLNgJ2RvYiUk
	 WCDgWTJcXb6nytD55myF9IGj/JCZ7QoTQONOk3VeerfQ/g5zpYGaTHRsTzMM79nw2X
	 Em3dsFwDr+d5grdXzn+H+QrawNpjijvkg3QCoqmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKUQ6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:58:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42074 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:58:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so5294553wrf.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 08:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rs2UyyOfjk+a+uubCpA54vHU4bdaxT3WN2RGWCgoouA=;
        b=j0NY1Y7fF3cmcF0j4/XqBAiSzPWlT94u4KZxOQ4SHd2gjiI01XbgtBNXJT6Ljy/utj
         xFUHcENj/jnU4MquyJmcTyvQX8HTYrOIqzm0hv6oPR68tFwXxV85GR+v6lgAmSOsCNo9
         2Q3xVhYZC/gBSYvnkx0OIJSo4/TbS/dpfr/5DWoohs4JZJn2p9Fl7kJ692QsZ/CXYVHD
         IrNKPEgOpAD3qqPDbvRCGR5iNFfK8Djh5613qgfMfBpaHofWU36Dx8uTcahMErOaPzxl
         y/Y0QqxJR8221w926USJfWjMzEHGW6cfES5S5VqR5jbadtHLK7TyCbJyIeImQFSQVt2C
         uFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rs2UyyOfjk+a+uubCpA54vHU4bdaxT3WN2RGWCgoouA=;
        b=PtDxxX6D3o8DbDVH7AkI3KdERVXghoFpJxI6JwzWmLpNEVU7WZYvx593xL3oAjEXQV
         Dkgrk+tkZ4aULKUW5PN74qTfG67mWNCh5i1dBgfHqNbhHpg+r2OD6s5A2v800150Bsdo
         xSONO4rAzhvqkBvd2X61MzGUO1dYGMVOzvkJlF8mWfoyInkxsi+T7hVpIP8wIcff9Ytk
         yE4WV1qOj0AkOCeKeZTJ+S/u+RN3GfwPnvzf0bxc5W8fza2sLY6s6Jjhz63krXtiZZaf
         lfn6fRZCywVSo4yN9nHcYr1ojbZpBAgpkgLQSKXwbSomMaJBHE5UjBz6pW5gIK4UjwSq
         TWnw==
X-Gm-Message-State: APjAAAU+gKT2vMMNI71BFDo0b0D3Kfju0Eb6g5dFZcGIVfE/8GJfcFzx
        ZRwxIea8Tvc3+zOLqW58rgs=
X-Google-Smtp-Source: APXvYqz2b1RTChhwZ/E0O2/jjFD7wt4Wq7OT288DvRDKp1fYKbE2p1NvPqgR7At48KxuK5fBTtqHEw==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr4517132wrv.77.1574355506478;
        Thu, 21 Nov 2019 08:58:26 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c11sm3770478wrv.92.2019.11.21.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 08:58:25 -0800 (PST)
Date:   Thu, 21 Nov 2019 17:58:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, peterz@infradead.org,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] x86/mm/pat: Simplify the free_memtype() control flow
Message-ID: <20191121165824.GA12042@gmail.com>
References: <20191021231924.25373-1-dave@stgolabs.net>
 <20191021231924.25373-2-dave@stgolabs.net>
 <alpine.DEB.2.21.1911201901270.29534@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911201901270.29534@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 21 Oct 2019, Davidlohr Bueso wrote:
> >  int rbt_memtype_check_insert(struct memtype *new,
> >  			     enum page_cache_mode *ret_type)
> >  {
> >  	int err = 0;
> >  
> >  	err = memtype_rb_check_conflict(&memtype_rbroot, new->start, new->end,
> > -						new->type, ret_type);
> > -
> > -	if (!err) {
> > -		if (ret_type)
> > -			new->type = *ret_type;
> > -
> > -		new->subtree_max_end = new->end;
> > -		memtype_rb_insert(&memtype_rbroot, new);
> > -	}
> > +					new->type, ret_type);
> > +	if (err)
> > +		goto done;
> 
> Please return err here. That goto is pointless.
> 
> > +
> > +	if (ret_type)
> > +		new->type = *ret_type;
> > +	memtype_interval_insert(new, &memtype_rbroot);
> > +done:
> >  	return err;
> >  }
> 
> Other than that.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks - I rebased the v2 version in x86/mm with this cleanup included.

Two days ago I noticed a similarly quirky control flow in free_memtype() 
as well, and fixed it via the patch below.

	Ingo

==============>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 19 Nov 2019 10:18:56 +0100
Subject: [PATCH] x86/mm/pat: Simplify the free_memtype() control flow

Simplify/streamline the quirky handling of the pat_pagerange_is_ram() logic,
and get rid of the 'err' local variable.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index ea7da7e62e17..af049920e59a 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -656,7 +656,6 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 
 int free_memtype(u64 start, u64 end)
 {
-	int err = -EINVAL;
 	int is_range_ram;
 	struct memtype *entry;
 
@@ -671,14 +670,10 @@ int free_memtype(u64 start, u64 end)
 		return 0;
 
 	is_range_ram = pat_pagerange_is_ram(start, end);
-	if (is_range_ram == 1) {
-
-		err = free_ram_pages_type(start, end);
-
-		return err;
-	} else if (is_range_ram < 0) {
+	if (is_range_ram == 1)
+		return free_ram_pages_type(start, end);
+	if (is_range_ram < 0)
 		return -EINVAL;
-	}
 
 	spin_lock(&memtype_lock);
 	entry = memtype_erase(start, end);
