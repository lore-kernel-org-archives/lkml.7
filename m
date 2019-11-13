Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B99C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E44222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgQvW1rY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKMHap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:30:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42076 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfKMHao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:30:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id j12so692578plt.9;
        Tue, 12 Nov 2019 23:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GnSXj7wbOxCwDVVSqPJHVgWQMahBnkDDsOVZqkoPHfw=;
        b=YgQvW1rYs43N9tt+FrafUjoLcqiOXKM3ivn01JzvOkrqRRDCGR4nKEBvfz+i3ABoAn
         EZHF6aQA29o4OeBz+csG0K/4VU24c3f14BM3gCKp9VkXwSzqWAo8tosSN2D6Q0+eKmWO
         eYonWlpWzeshvRJOiwnEe05jh3KNvxDS5j6b5F5+w78VT/BDv77IK/GH4UG88JLmdwN1
         s/KTVccPpLxZg2KTRpkgj5cabF579+EGODiOp6GdDmeyzH7DQIdQMy9tWHNw3qhTJ6v+
         mPPHHSQyMFxr4dz/GaiM3lGX8Xmk92hvpRLP31Dhw7NPfht/bz/e2o+0YiYYmpO6R9Ix
         QFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GnSXj7wbOxCwDVVSqPJHVgWQMahBnkDDsOVZqkoPHfw=;
        b=qq0C5okjhCl4+6rQJ/Z7gTJhHkUQBDzxBid9eTjx1kcY/+ZG7Sgof19n1SUt4WuQ0y
         vT9lY7GLeJZmOKXfqcTf6VjAs5GQKh6WbStkVcNkhEcmSjdZGT1h43SNpC0nkOPtUdJH
         NLRY9jNMs6nExeSOqlF9yVqpkCtlahftpSc2rknARDKYaqPtY469+Pu311mnNf6bsZuQ
         3oNLP58OzXPmZMhwBDSDQnETlpvMZmRm/hCU0nPLpNMAaAPIUxpMr26bdahuvOnwkaF3
         i5RvqBchBI9z6YXCyvLFwzntuVKRY0vVW8WWzzB9O4Idwz3Q+a6WddZTYMkCn5PdHpR4
         DIwQ==
X-Gm-Message-State: APjAAAUTiJpfP1SHaJ5KYaUasRpbL3Eg+CZhI0cYHB1xKzkftiD2qvaF
        hVUxFyP6+t/yZVXkFJRQJXs=
X-Google-Smtp-Source: APXvYqyggFF3SArQPwr6oi9Nn5mVEY51JDuGeFs6A8hWrChD23Cxw98xuKIpAScywnA/KAr0bD5MCA==
X-Received: by 2002:a17:902:6ac9:: with SMTP id i9mr2261051plt.218.1573630243614;
        Tue, 12 Nov 2019 23:30:43 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:166c:698d:7a64:6a4b:9d08:b425])
        by smtp.gmail.com with ESMTPSA id q12sm2095770pgl.23.2019.11.12.23.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 23:30:43 -0800 (PST)
Message-ID: <97b1695ebcbd2dd5ce8c117af0232ad6a1fee20f.camel@gmail.com>
Subject: Re: [PATCH][RESEND] docs: filesystems: sysfs: convert sysfs.txt to
 reST
From:   Jaskaran Singh <jaskaransingh7654321@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        christian@brauner.io, neilb@suse.com, willy@infradead.org,
        tobin@kernel.org, stefanha@redhat.com, hofrat@osadl.org,
        gregkh@linuxfoundation.org, jeffrey.t.kirsher@intel.com,
        linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Wed, 13 Nov 2019 13:00:36 +0530
In-Reply-To: <20191112100454.3b41f3af@lwn.net>
References: <20191105071846.GA28727@localhost.localdomain>
         <20191107120455.29a4c155@lwn.net>
         <cd9dbb3704d0a39a161c3e4df8fcd9f84bbc5b03.camel@gmail.com>
         <20191112100454.3b41f3af@lwn.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-12 at 10:04 -0700, Jonathan Corbet wrote:
> On Sat, 09 Nov 2019 18:36:16 +0530
> Jaskaran Singh <jaskaransingh7654321@gmail.com> wrote:
> 
> > > At a bare minimum, an effort like this needs to put a big
> > > flashing
> > > warning
> > > at the top of the file.  But it would be soooooo much better to
> > > actually
> > > update the content as well.
> > > 
> > > The best way to do that would be to annotate the source with
> > > proper
> > > kerneldoc comments, then pull them into the documentation rather
> > > than
> > > repeating the information here.  Is there any chance you might be
> > > up
> > > for
> > > taking on a task like this?
> > >   
> > 
> > Sure! I'll send the documentation patch(es) followed by a v2 for
> > this
> > patch.
> 
> Great.  As an alternative, if you like, redo the current patch with
> the
> other suggested fixes and a "this is obsolete" warning at the
> top.  Then,
> after the subsequent improvements land, that warning can eventually
> be
> removed again.
> 
> Thanks,
> 
> jon

Hopefully I can get the kernel-doc comments right. If not, I'll go with
the alternative :)

Cheers,
Jaskaran.

