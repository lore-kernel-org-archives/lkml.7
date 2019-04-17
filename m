Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D6C282DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F174520663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555529225;
	bh=4FG/vpHLcScUNeEiVNMqJi9l9zSU+rQKpVlXo0klMBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pCZKcbcZrXwibyFORRMgyBrtag/jNH5nXXGEquHViXFjh8VBamfyzf3Y0sKysjsjo
	 ZvGIOzTgcStGxvRZnlFJd2FJEVtPPsa6Z6HSFzWCvBqYIIl1AtOL8qm02zYqb92Izl
	 hHZtJIjE8Vlp3uFptWklXC0yj/5HUDC3QCbO8Mxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbfDQT1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:27:04 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35801 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732543AbfDQT1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:27:01 -0400
Received: by mail-yw1-f67.google.com with SMTP id d132so9011670ywa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V++xunfQyx5HqwjAXgd31K7Me21LJ+w2CP6EKEHvb5g=;
        b=sEYWM3GFOjveqnLmmV/m8t7Zmz1eLXxJNrRyM/47EIkG7U48BTtdYGfv5mNPVIhZj5
         ydlXv7ZU+bOkuYELPU8V87hJLbQ6RM+9bNRXL0HEFaX/sy1RJSXLVOK9NOg/+suTYLcr
         pPCkzIuyXdqzA3r879dYbIXADhS+k4AJVsVJfSkJzL6xXep07lhb2aZYsEVFp2HY7ue0
         k6MEApqF/6t/uzQI4EkEkz4WO8oSArLVCNZq5O9J5keNpf85ip3JnCeW7HpB1s91fJX0
         ezs3/Q9rrt6/0YjKzBfJw6K8KJQ/V1U0/UaWgNyWTZKniGFoXII8J13Zh5oDRF7Ffn4M
         5x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=V++xunfQyx5HqwjAXgd31K7Me21LJ+w2CP6EKEHvb5g=;
        b=BC1VxoP9DCdFq36LZzsK54q/f3m/naWT3bMShLgN32xuyiBhj66yx8pEs7r2zymJUb
         MQE1ZSi/b4hkvbNWwcbxjuVy+9Eva0ScfyCFBsTgDyI6ybYyHivXqjkxDlDlA5iHLMdn
         D8diZRZuBFI6hspM5LxTaB0X9LZ4Po3stfOxl4+tcDpdj1pkuHN8OthT/M3jlMD4BkHg
         GaIkUgzHfXDCY2RW49SXpX8bs/rCtuVMv/5QpFTv0jfNASK90UHjbmccfiMicpRS0OZ/
         /p9DxCXV9m8ccHRPJXnW1cGupi8NRLjfjIau3yba5JlMf7vBeEDoYeWp5Ln7VikU5OTi
         giEw==
X-Gm-Message-State: APjAAAWHru0zbbi5lpEtAdtgSo1Fx7NMvWVGMwVwTEnWd3XCyLu648j0
        eY12r8jz7XQ4qzwBCW5OnJI=
X-Google-Smtp-Source: APXvYqzaE2VFSAPgJb3LRYWGKGBEcgGwPIn/fCuPMmPJlMdhElWg7AKR5dsfhAC275ZQtahKn/aeRw==
X-Received: by 2002:a81:4d55:: with SMTP id a82mr72632019ywb.271.1555529220329;
        Wed, 17 Apr 2019 12:27:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:556d])
        by smtp.gmail.com with ESMTPSA id h131sm18444890ywa.80.2019.04.17.12.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 12:26:59 -0700 (PDT)
Date:   Wed, 17 Apr 2019 12:26:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/1] kernfs: keep kernfs node alive for
 __kernfs_remove()
Message-ID: <20190417192656.GE374014@devbig004.ftw2.facebook.com>
References: <20190416155335.14627-1-khorenko@virtuozzo.com>
 <20190416155335.14627-2-khorenko@virtuozzo.com>
 <20190416191727.GD374014@devbig004.ftw2.facebook.com>
 <0469256f-7af9-c9cb-1c64-5d4bebfad095@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0469256f-7af9-c9cb-1c64-5d4bebfad095@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 17, 2019 at 04:12:29PM +0000, Konstantin Khorenko wrote:
> i don't know the full scenario unfortunately, but the idea is the following:
> 
> __kernfs_remove() is called under kernfs_mutex and if
>    !(!kn || (kn->parent && RB_EMPTY_NODE(&kn->rb)))
> 
> it assumes that nothing can change while we hold the mutex and
> for each kernfs descendant should have kn->count > 0.
> 
> =====
>          /* deactivate and unlink the subtree node-by-node */
>          do {
>                  pos = kernfs_leftmost_descendant(kn);
> 
>                  /*
>                   * kernfs_drain() drops kernfs_mutex temporarily and @pos's
>                   * base ref could have been put by someone else by the time
>                   * the function returns.  Make sure it doesn't go away
>                   * underneath us.
>                   */
>                  kernfs_get(pos);
> =====
> 
> At the same time kernfs_notify_workfn() can do a kernfs_put() out of kernfs_mutex
> which probably can be the last put and dec kn->count to 0 any moment.

Yeah, but the caller of __kernfs_remove() should be holding the ref,
so I don't see how it'd reach zero.  Also, just putting that one
kernfs_put() inside mutex can't possibly be the right solution given
that the function is allowed to be called from any context.  I think
we need to understand what's going on better before making changes.

Thanks.

-- 
tejun
