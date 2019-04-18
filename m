Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF9C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E9B217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBO6Wp3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfDRBos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 21:44:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38168 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDRBor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 21:44:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so393933pgl.5;
        Wed, 17 Apr 2019 18:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MzjPpnoXEbsEM/B5pimFouu3ItZ7AAJKqejdoIFMMLI=;
        b=MBO6Wp3oDEm+26DyRLbcD2J5evIuTXBdagfYhT4dukyZj7LKgu6r0nD1mP499TdcWR
         so78mannP5E4Ou3H6TRvL8u9i8RLGq3X8snZxWeRjaHG/N5G83c2ozhPgLelP3qJaJSh
         9A7OXUvQFtoVcVt1Hv54waydQobr9r9ZoYqKHk8UW+N1I18s6SzJJItYMN0N87a51u4g
         02oUdR2O1OOcP/9CsHfDOHWduO26tjHePxUG4wCIOPtgrDTJlHDne3qEIguOdHaGEZKl
         TrjJomGOJX/TRfqESYU5jdfFzu8DkpMP/Cx/PyCh4AaxP0QzeoA+EJZN7vXdOP0d74dP
         rwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MzjPpnoXEbsEM/B5pimFouu3ItZ7AAJKqejdoIFMMLI=;
        b=k70KyYjVOTVwG749jgMm8uFcjhg2j3j7SSrCdQSak3Lke5Z2VuXDBwnQ2TFOiQouHf
         rV6cxIcHWrV/Rwjvbu+8JZXbIhyXTT6LDwFIwEZdIzRzh5wyJ00ageRilGRRrjwydLIy
         RZ9dAqSRj8c00lIiG8EuLZ/CAmBRuvZYjpjGWDK8obohwEo/nypz3B6m8ThsF2FLbGHT
         /ojOyV57UGK5XLqrxhf/NmyXIWU9T6UcEHRhDVt9Aunc9avz7BTBQlTxauulrh4R1P6C
         /CGy4c4ZMpNdkWX7NSGzAdOYFOO+L1giz9UhyRpWxpQEB1SeypjDRbsKVZB/GLek909q
         l/VA==
X-Gm-Message-State: APjAAAU3bObZus9d2WVmG7ebafZdwEFO7FetOGer3kTlM5DlI3YE9UlR
        weNH68SnWtvh1yxPEc63SO4=
X-Google-Smtp-Source: APXvYqzuR6DAmLJtQtZaQO6y5ps8jDVm4PFfroRe7sRLxh4TI/CKzz63RBg8By1louuFyqbKFbbdZg==
X-Received: by 2002:a63:1043:: with SMTP id 3mr85617214pgq.283.1555551886015;
        Wed, 17 Apr 2019 18:44:46 -0700 (PDT)
Received: from localhost ([210.162.55.198])
        by smtp.gmail.com with ESMTPSA id r76sm613616pfa.39.2019.04.17.18.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 18:44:44 -0700 (PDT)
Date:   Thu, 18 Apr 2019 01:43:21 +0000
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martink@posteo.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a
 global lock
Message-ID: <20190418014321.dptin7tpxpldhsns@penguin>
References: <1554883176-24318-1-git-send-email-mojha@codeaurora.org>
 <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

On Mon, Apr 15, 2019 at 03:35:51PM +0530, Mukesh Ojha wrote:
> 
> Hi Dmitry,
> 
> Can you please have a look at this patch ? as this seems to reproducing
> quite frequently
> 
> Thanks,
> Mukesh
> 
> On 4/10/2019 1:29 PM, Mukesh Ojha wrote:
> > uinput_destroy_device() gets called from two places. In one place,
> > uinput_ioctl_handler() where it is protected under a lock
> > udev->mutex but there is no protection on udev device from freeing
> > inside uinput_release().

uinput_release() should be called when last file handle to the uinput
instance is being dropped, so there should be no other users and thus we
can't be racing with anyone.

> > 
> > This can result in Object-Already-Free case where uinput parent
> > device already got freed while a child being inserted inside it.
> > That result in a double free case for parent while kernfs_put()
> > being done for child in a failure path of adding a node.

Can you please describe scenario in more detail? How do you free the
parent device while child input device is being registered?

Thanks.

- 
Dmitry
