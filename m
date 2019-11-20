Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B8AC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12BF20857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6m+fvbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKTA2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:28:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44997 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfKTA2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:28:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id az9so12891700plb.11;
        Tue, 19 Nov 2019 16:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=59m1/eC8riScAm7JjDY1BbKSHZjxRRJlakTsu9UypXk=;
        b=u6m+fvbrFbkzotXSv+4PIHEhiipKPpH3/vM1YpESWnlFPCVgJilpTlwgPnd+l4t8os
         RbLOsK7eAbjW5D6UfBkBeuSAaf6h+vPC3zAA6VMNLQ2ekpIeu1EJSu/uc8OYmnzkId04
         N83RBv6vAB3ymbrk9iy9F9y48Pfo+0wWEwKfGuidCMdHLEhx3OcdfNXTZ6QyTkwdUk0z
         8YKLFWW6LZH2xMPvKAruN5e7qLJfCHqSafw4mvF+DdqTwbqFa3Ql/C5XHqd4MfUPicsU
         OfHUUKG2IClRvGmzJTLiYLN6BqznKfVSxPWHjJQ2lBnn9Pvw0hFXzMZTz8TRSF5V2k0q
         UqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=59m1/eC8riScAm7JjDY1BbKSHZjxRRJlakTsu9UypXk=;
        b=iuRIe7wQiMFTmvVBpwOMaPFUa4F8/vn75OF6vNyLcGEfjrwPfccmchf0aNU43DHOnT
         //ptjpf7JWxC/fjE8oU9r3GEnLpBacS01sU0qJhueb3GDa9XYyusc37E8bE/2YYIWJuM
         yj83pwLRUJ0ka3v4Unos9u9Ix/9V8s+IAWCwaTjKLz0Q/RpYSbP42JmqFIm2fSo5yRlJ
         wpxRF6jyZ3a4Uw129MeUunFb16+m52jqdp/oNYSYBZBrRvW/YY5Xz4FIKf6oV7jNF12K
         rccXcQ1mAVeiH+5//3RxqEXnbNtWp3bSilY3u3/sp4ZkRcvXz7r/Mi9YFeUUxjy4NufL
         Ulcw==
X-Gm-Message-State: APjAAAVcDL7rzos5pmGa+IgeXv4uClwhd49mUlZVgEYQVG8n9B2JFCaD
        RrsGs/haUmRv6bA9h35HylY=
X-Google-Smtp-Source: APXvYqwR7pa5QPsLveMk9oWSg5gV6GTebzlLq2pddIcNPZ1ASeWDJj7HhjTX0jV8jEDny143ZyKy9Q==
X-Received: by 2002:a17:90a:1742:: with SMTP id 2mr385613pjm.93.1574209729243;
        Tue, 19 Nov 2019 16:28:49 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id v63sm26454431pfb.181.2019.11.19.16.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:28:48 -0800 (PST)
Date:   Wed, 20 Nov 2019 09:28:46 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jonathan Richardson <jonathan.richardson@broadcom.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        sergey.senozhatsky@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: console output duplicated when registering additional consoles
Message-ID: <20191120002846.GA255928@google.com>
References: <CAHrpVsUHgJA3wjh4fDg43y5OFCCvQb-HSRpyGyhFEKXcWw8WnQ@mail.gmail.com>
 <CAHrpVsW6jRUYK_mu+dLaBvucAAtUPQ0zcH6_NxsUsTrPewiY_w@mail.gmail.com>
 <20191114095737.wl5nvxu3w6p5thfc@pathway.suse.cz>
 <20191115043356.GA220831@google.com>
 <CAHrpVsWu54rKg3bGhY6WVj5d-myYxGSEkxGhOJKTyyc1EH4qOA@mail.gmail.com>
 <20191119113027.74lp3dsg5ftvylp4@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119113027.74lp3dsg5ftvylp4@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/11/19 12:30), Petr Mladek wrote:
> On Mon 2019-11-18 13:38:04, Jonathan Richardson wrote:
> > On Thu, Nov 14, 2019 at 8:33 PM Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com> wrote:
> > >
> > > Gosh, that part of printk is really complex.
> > >
> > > On (19/11/14 10:57), Petr Mladek wrote:
> > > > For a proper solution we would need to match boot and real
> > > > consoles that write messages into the physical device.
> > > > But I am afraid that there is no support for this.
> > >
> > > Wouldn't those have same tty driver?
> 
> Interesting idea. Well, do early consoles have tty driver?

Good question! I'm not sure.
netcon, for instance, doesn't have tty driver, yet still has to find
a proper net device to write the data to. They have some magic inside.

	-ss
