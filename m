Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984BEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6210620882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014536;
	bh=x7g3VKexj/qw7eP2MB2s7W13m1At6S07QF2uT+1df74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mwn75cbAPpg0T5axqdfVn+xVcC9nFUKZKMLvbGTcz4v9qyBi4yeoA4hx2qVYT5GEz
	 f6d0AlguNd/VnCj3EmpMB61K5u3m/CfLj5Zd366cjaPIeSlA7IGeyCxLYo2QWCZUd/
	 BO1/XVn4UYv1ehemo64hSc7wEyF9UqCqhGrubQzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbfCaGmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35443 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731371AbfCaGmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id p19so2941533plo.2;
        Sat, 30 Mar 2019 23:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=a6HP0eefddWRKrsahEXCUmMAqHDkFOjMKsMGUn0MlK8=;
        b=d+ruCkgpQk/TyGrYAYPl318YRnuE+ARIaHw0XXjqWW/MzBHwZ4zo/LIMiBWP0S99Rw
         lfA5rK+DhC7AjW+dlF7S92VUsGC+on7Ga5PtH1hKfWyGlxv65YjVI4VPCx7QmFd5V+iU
         av5ircWNc4YQe2ywce4c1FTGZnNe0z6OrtCVYOBgt/Zye3gO17jqKxAkDsY4Y0OzKSRC
         lVXdAFXrgi+2SsD7qbW5zcMdgucCaxLJ5p6GkdUVU1zxNiNkBk/8uS/1iBjDxF4G0WGe
         rZvfrrPbS7TDQJBE4btHEAbdWuj4JtjXHt62C8jCZHeQ+E4eAm3gRfq6Y55mBogM/Axd
         7VVQ==
X-Gm-Message-State: APjAAAX4hpUp/r6NH1ZrDp6Cjt+KcFbyBo+Eo3FwTmJXAYBX+cUSivgZ
        4F6VhoX3uXPDfcTgIcMpbg==
X-Google-Smtp-Source: APXvYqy0pb68FmyuGAsGm0tkZ5S8Iyl8lsuOAkqYM3FNkHvEWcAhAryIN6p97OPxNHOrwy6fKRlX0Q==
X-Received: by 2002:a17:902:801:: with SMTP id 1mr25814510plk.299.1554014532463;
        Sat, 30 Mar 2019 23:42:12 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id c1sm9208708pfd.114.2019.03.30.23.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:11 -0700 (PDT)
Message-ID: <5ca06143.1c69fb81.65919.5944@mx.google.com>
Date:   Sun, 31 Mar 2019 01:42:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/6] device property: Add fwnode_get_name for
 returning the name of a node
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326124106.27694-3-sakari.ailus@linux.intel.com>
X-Mutt-References: <20190326124106.27694-3-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:41:02PM +0200, Sakari Ailus wrote:
> The fwnode framework did not have means to obtain the name of a node. Add
> that now, in form of the fwnode_get_name() function and a corresponding
> get_name fwnode op. OF and ACPI support is included.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c  | 24 ++++++++++++++++++++++++
>  drivers/base/property.c  | 11 +++++++++++
>  drivers/of/property.c    |  6 ++++++

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/fwnode.h   |  2 ++
>  include/linux/property.h |  1 +
>  5 files changed, 44 insertions(+)

