Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECB5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D280320835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555487673;
	bh=lbTW7zadAZ8ruO4angxDY3WxpNRJw53Vap5WXBY/vbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c3OI9GlsMMkfqqEJZ8FsJYkEC6jw59LsDlH7TQcaBsUJ4GiFMH9teCDBSSetMz2bK
	 NgXWcwtwrdrJkZjNx+70pXBBELN+eCqyB3fTzc3rqkO8KgKX/GObky1KQfQ9W2fbJH
	 ZmCsNSJZ0Po+exK1/Z0Q8G3Nyd65lQLVpxHJjjpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfDQHyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:54:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35693 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfDQHyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:54:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id m10so19951003otp.2;
        Wed, 17 Apr 2019 00:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTl9T3JQQQHfT1Ga9K8gTFeYcNPuJ9Df/lhTAgdftzM=;
        b=hDeHwe92DHKLqi1uTpKeu5aZa5gg31mMLvuqclpGbfulyj57o/eMWhzwp9yF+sxePX
         eDlAU4ljFzbpZpsPDWL5DKyvwcOOrsIEts0AcPTokOCbpq1qFlmuw0RlxVyhCm7pA13F
         3rtYH7oQGNNcxEeInXBygS6c2NWj40S1zhnHV98SNmq7i7iMd/vGq5oAbiVtIvh28hod
         KCrkxABs/JbJ0yGiWLcKck8Xdyp1jmrRpHpIRnylDmxnIZsodW7hUJWuOhMvULrXWWuP
         qqz4MOneXoeme7LcSZI8fA3dXtC87Re1qUi6s3mlnMlSPHGy4P4WyzuQfu8dBUp/xE7Z
         PxFg==
X-Gm-Message-State: APjAAAXBBxSsfaiKuXho9kcQ7UvXTjz7TPfsT64YHI0QKctua9U2SvjJ
        XFiRuZY8uOmYDHN2v1MHUeuDqPD11yRbrgMZ8ek=
X-Google-Smtp-Source: APXvYqzQRITJNcLXGTXGHKccQwdKNMDXWuhl2GHkroxxxcLCPqmvDeS3wx042E4Uvg1Kho2fIVWCMQRc0KSgFtValnY=
X-Received: by 2002:a9d:2dea:: with SMTP id g97mr34508351otb.20.1555487671198;
 Wed, 17 Apr 2019 00:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Apr 2019 09:54:19 +0200
Message-ID: <CAJZ5v0gg9cwbNXS=88CdC6dioYaxPCVKx-PSU86PFjvU77MdRg@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Software fwnode references
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 3:42 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> This is the third version of my proposal to add reference handling to
> the software node code. In this version I renamed ACPI_NAME_SIZE to
> ACPI_NAMESEG_SIZE in 6/13, and slit patch 9/13 in two separate patches
> (9/13 and 10/13) as suggested by Andy. Patch 9/13 will now only move
> the registration of max17047 out of probe, and 10/13 will introduce
> the software nodes.
>
> v2 commit message:
>
> This is the second version of this series. In this version I'm
> introducing a new helper device_find_child_by_name() as proposed
> by Andy. Andy requested also another helper that could be used for
> chaining the fwnodes, but I decided not to add that now. I would like
> to still think about how we should handle exceptions like if there
> already is a secondary node assigned for a node.
>
> v1 commit message:
>
> This series adds support for software fwnode reference handling. In
> practice it means making fwnode_property_get_reference_args() function
> usable in the drivers also with software nodes. I send the series
> originally as RFC [1].
>
> As the first user for the software node references, I'm converting
> intel_cht_int33fe.c to use them as part of the series.
>
> [1] https://lkml.org/lkml/2019/3/15/457

I added this series to the bleeding-edge branch last night and it
triggered some warnings from various checkers and there was a breakage
report from Hans.  All of that needs to be fixed IMO, so I'm expecting
an update.

Thanks!
