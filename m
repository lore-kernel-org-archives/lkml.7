Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A62BC04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3765320652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCIillAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfD3JIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:08:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36754 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfD3JIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:08:11 -0400
Received: by mail-lf1-f68.google.com with SMTP id u17so10279000lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9HjQ88MY4ZiDc1bI5n4MIBBh4bZ2A3E/q/QZEBk7alU=;
        b=KCIillAxrZrXB5w7B79fb19nYg7F3YCwf/ztmA9aoE9VUD7WLkEyGA1XTGj7Kk7I9I
         Q513ZwfxLRI6HJ4DrN1ZMjXfa842QSSs6yPwd0FUt+xZKwllptZpyag00LUFcGYK3EsC
         XdEbFchQbx1GNf/krTIlE74LPo3MefjF2xV0uZ5Rt9BcNTBf/J2/0tgE/CjrS+/46uwD
         ARjeDWBBqlnHHRKTKdiGH05RWZ9Qh2z5qOAaNQx9+9uWyCnSM+J6HGsn9mtkAkyisNb6
         WLz5Pn17WNGE47oaQuTDdvGZvJ9oPYfrIEusa3M0SiUmfS8nh2ODl35nGOliRsB/77U5
         zOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9HjQ88MY4ZiDc1bI5n4MIBBh4bZ2A3E/q/QZEBk7alU=;
        b=CRs2/jDPmNgUUM1lD+017iprN+Uxzi4z7yp1t0bS55eSukG9f7VrrTMHfzQhhwBqDd
         Yfw1jRKUDIVXVMTSq9/LGeUJ+FVEQVmvEpXDx4hKld+qb+VrcUgKMC4MCf/wXlvCWirA
         ZjjICN/cBW3tvuqS1Eojvjb+cLZGy+2dLeoOOsLqaxZYSIHl/LWiocQKfR1nprRgvET/
         Uojb2KhRFCrMVHh+xNuK7YScXZB5/IDKTbk5YBjMseBxeYjvUTtLJ3aEiGvMvJAgD/hQ
         YANyIuH8IJQbSQBFXTjblitW7H5vZ2zgOLHFy1e55nAAHRBDVVUXkUMZWlsghCJz7HW6
         RNgQ==
X-Gm-Message-State: APjAAAXEsdq5kpuBP2HyOIkpSLuE/QYr1LmUVq5rKUshcFIB350xrOID
        +YPci3TsxVRvnliG5mQ5uCc=
X-Google-Smtp-Source: APXvYqxC1zZd7LprV/dgF44Ba5ne0SfC/5gxd6UPTeJBnWPoKvFHoqjjCKTMw2d90XkBC0hQgb2Gkw==
X-Received: by 2002:a19:f50f:: with SMTP id j15mr36291099lfb.135.1556615289352;
        Tue, 30 Apr 2019 02:08:09 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id u22sm1374696lji.40.2019.04.30.02.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 02:08:08 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 45A444603CA; Tue, 30 Apr 2019 12:08:08 +0300 (MSK)
Date:   Tue, 30 Apr 2019 12:08:08 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, rppt@linux.ibm.com,
        vbabka@suse.cz
Subject: Re: [PATCH 3/3] prctl_set_mm: downgrade mmap_sem to read lock
Message-ID: <20190430090808.GC2673@uranus.lan>
References: <20190418182321.GJ3040@uranus.lan>
 <20190430081844.22597-1-mkoutny@suse.com>
 <20190430081844.22597-4-mkoutny@suse.com>
 <af8f7958-06aa-7134-c750-b7a994368e89@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8f7958-06aa-7134-c750-b7a994368e89@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 11:55:45AM +0300, Kirill Tkhai wrote:
> > -	up_write(&mm->mmap_sem);
> > +	spin_unlock(&mm->arg_lock);
> > +	up_read(&mm->mmap_sem);
> >  	return error;
> 
> Hm, shouldn't spin_lock()/spin_unlock() pair go as a fixup to existing code
> in a separate patch? 
> 
> Without them, the existing code has a problem at least in get_mm_cmdline().

Seems reasonable to merge it into patch 1.
