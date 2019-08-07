Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DFCC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3780321E71
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PPvkKFCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbfHGRuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:50:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37377 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbfHGRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:50:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so41927773plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5KYdXKYr3bi4ww2mKAeTRpDv73zJSo+1vXG/G3ODqB4=;
        b=PPvkKFCSYn8yjBmUNgneoKHyWptFiSw9Fscm78H29QqTnREErCk77l0nShOcTavsES
         iKEIl2StD6GseDdEkWxKNcVFzFKTYKdAKWSuBUnDcVZtiflSRJxvserT1G6lumK4gWcp
         xmzz0wozXfCe44vN4IS794SMn+U9szr4wB8aLe6PDERwXplNVD/mXKvbM1uf6cAdW+dJ
         Dbygcb6cfnRV+JV+lsgtJjoiha2E2LU5k7SGnznEee6LkRW6Sae7nMRtgxi+jMa2p52P
         nPlv76ct6GQjlA34j/SL/Rrda963I3vPp38U+wjxG2Z6FDTmQMwZNAxm/j2wGrki4cZB
         Zoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5KYdXKYr3bi4ww2mKAeTRpDv73zJSo+1vXG/G3ODqB4=;
        b=JV04L6Ay4OEXlroa4hnhXgN5DIbcrFzVUdvICBDzh5THFOih8EXVLjxbNFoRMT345f
         6qOSVqKVf+ZV5i2VP9ZVhXXgVgb7jbnOY2Lwz/cbW8Nbd9Sf5ZHPYhCmKxGKCm5EAGRX
         0JUv8Iaj55qpDR+5NkMPQo7NrWAVzqUN6Jl99M/xjju2LsGluAvLn7f/ls5tbgA/+RLO
         NcSvhtwduNhVTFSM6Efk7mE3pSK2uhMWyN7CZ+X8LxUgZS3FJ6vegQs9vFYFw5FOzSSu
         s01BBWZ12UrBdwMjXuorAvtZuJzLbCqFvYOK+iV2VbuJpM3/1AWve+63hegz+jnn5NAL
         Jk6A==
X-Gm-Message-State: APjAAAXsGEhKa8W4Rr4Rn4fFgwFrveZ3ewlA2ic+ju+Oy+1FHdiS+1ZT
        QBfAdRBIcR6vcEixWTCVDKg6wA==
X-Google-Smtp-Source: APXvYqyBd1In7OO0v6ShLx+XwB5zNo+xJhWaxJDjYvfWQ72W167HxcctNcW92Y5dW5kT7biDDCGWxA==
X-Received: by 2002:a17:90a:23ce:: with SMTP id g72mr1044079pje.77.1565200209101;
        Wed, 07 Aug 2019 10:50:09 -0700 (PDT)
Received: from brauner.io (c-67-180-61-213.hsd1.ca.comcast.net. [67.180.61.213])
        by smtp.gmail.com with ESMTPSA id a6sm449137pjs.31.2019.08.07.10.50.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:50:08 -0700 (PDT)
Date:   Wed, 7 Aug 2019 19:50:06 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hridya Valsaraju <hridya@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/2] binder: Add default binder devices through
 binderfs when configured
Message-ID: <20190807174937.53qo7uninqi3c6xq@brauner.io>
References: <20190806184007.60739-1-hridya@google.com>
 <20190806184007.60739-2-hridya@google.com>
 <20190807110204.GL1974@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190807110204.GL1974@kadam>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 02:02:05PM +0300, Dan Carpenter wrote:
> On Tue, Aug 06, 2019 at 11:40:05AM -0700, Hridya Valsaraju wrote:
> > @@ -467,6 +466,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >  	int ret;
> >  	struct binderfs_info *info;
> >  	struct inode *inode = NULL;
> > +	struct binderfs_device device_info = { 0 };
> > +	const char *name;
> > +	size_t len;
> >  
> >  	sb->s_blocksize = PAGE_SIZE;
> >  	sb->s_blocksize_bits = PAGE_SHIFT;
> > @@ -521,7 +523,24 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >  	if (!sb->s_root)
> >  		return -ENOMEM;
> >  
> > -	return binderfs_binder_ctl_create(sb);
> > +	ret = binderfs_binder_ctl_create(sb);
> > +	if (ret)
> > +		return ret;
> > +
> > +	name = binder_devices_param;
> > +	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> > +		strscpy(device_info.name, name, len + 1);
> > +		ret = binderfs_binder_device_create(inode, NULL, &device_info);
> > +		if (ret)
> > +			return ret;
> 
> We should probably clean up before returning...  The error handling code
> would probably be tricky to write though and it's not super common.

struct dentry *mount_nodev(struct file_system_type *fs_type,
	int flags, void *data,
	int (*fill_super)(struct super_block *, void *, int))
{
	<snip>

	error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
	if (error) {
		deactivate_locked_super(s);
		return ERR_PTR(error);
	}

	<snip>
}

	deactivate_locked_super()
will call
	fs->kill_sb(s)
which calls
	binderfs_kill_super()
which calls
	kill_litter_super()
the latter will destory any remaining dentries and then calls
	generic_shutdown_super()
which calls
	evict_inodes()
which calls
	evict(inode)
which calls the binderfs specific
	binderfs_evict_inode()
and get rid of the rest.

So manually cleaning up is not needed, imho.

Christian
