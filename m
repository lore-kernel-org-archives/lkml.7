Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD24C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805772084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky3SesKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfFSJvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:51:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46097 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:51:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so19027996qtn.13;
        Wed, 19 Jun 2019 02:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3eEZ2qQ0T+vNBvySVU2f2K2n0PUB27s0eFB2a2GHHpw=;
        b=Ky3SesKJdQbqCg6lv2g/uWL5yTM5H21azkmaCE5DUZGzH7yfJ4LSMV8Zb26vGJbmqZ
         cDFJROUQLq4vKzYRjGbAuo381vwuIFZb4Wa9kgbHVSd2T4tfdZJl1SAcJk8Dz09rJBDS
         HR7nrt7HpYtm8rwO6wo9TvW3zgOnPa/CGc4hX6/AOgOXoCp49teZ9JiHZ560D2TyemSr
         DVR7LfcNpU7Y5Wb+gYtDZXthnNz4hUhVMF3KNA0j8DkOhC3Bf09mMhXi8AmiuXlGTi47
         HKVuKHudef9vuuqYNjjtxyX9cnlHkTfgJ2cb/skXM5JmyvFg/VlLbBi2A8fuF1YE3FpG
         zdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3eEZ2qQ0T+vNBvySVU2f2K2n0PUB27s0eFB2a2GHHpw=;
        b=WJGrwPOOJ0T5I1TPqbV0c7mmrEY6RCzJLMexRh6g/FT4rrwnFPODnYANaeQoVBN/uM
         kg3ybL6EdE9RAt1/X17Lw/gc0p2ztUgyPKpaM+WxKInba+xVnNCMWszSW07zMpdIQ1tJ
         NPByIRb2E9F4zVn491owU4HGL4PnlHrjnrYRtQ2ORnrMG78tpSANjRnGqJeYG7T2eU0N
         d22h4DgpkmN5cNwj6UTDfzEGAoSD5xmOCpZp4+GiEes4XMMQZT4vN34ypQIeSRMTBa3C
         B8SgeDFnpkKTBGMP7Nfy856hN+2xlwTWdjftegKjk26DPLgxbcYtc3KIywzrxeEXC7Ey
         pHBQ==
X-Gm-Message-State: APjAAAUdzbQToIutpF7BGeEpwFI2aprx6PqUM9uGZLUbOs1zKzMAFNqr
        fVb9FYthUQXX++rwA4p4Orbcb//ZJi4=
X-Google-Smtp-Source: APXvYqxY9AqHFrq4Px1xuxAzlm+uOWclwFVuRwuqndIRWiVaBEWV0tK9BgMpqoe3H3v/8lcSK1F9ZA==
X-Received: by 2002:ac8:3971:: with SMTP id t46mr85568562qtb.164.1560937896697;
        Wed, 19 Jun 2019 02:51:36 -0700 (PDT)
Received: from continental ([186.212.50.252])
        by smtp.gmail.com with ESMTPSA id c18sm10048430qkk.73.2019.06.19.02.51.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 02:51:35 -0700 (PDT)
Date:   Wed, 19 Jun 2019 06:52:09 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Hannes Reinecke <hare@suse.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_sysfs.c: Hide wwid sdev attr if VPD is not
 supported
Message-ID: <20190619095208.GB26980@continental>
References: <20190612020828.8140-1-marcos.souza.org@gmail.com>
 <yq1muieuu17.fsf@oracle.com>
 <850765d7-da85-3fc1-7bf4-f0edcb63f8d8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <850765d7-da85-3fc1-7bf4-f0edcb63f8d8@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 08:34:56AM +0200, Hannes Reinecke wrote:
> On 6/19/19 5:35 AM, Martin K. Petersen wrote:
> > 
> > Marcos,
> > 
> >> WWID composed from VPD data from device, specifically page 0x83. So,
> >> when a device does not have VPD support, for example USB storage
> >> devices where VPD is specifically disabled, a read into <blk
> >> device>/device/wwid file will always return ENXIO. To avoid this,
> >> change the scsi_sdev_attr_is_visible function to hide wwid sysfs file
> >> when the devices does not support VPD.
> > 
> > Not a big fan of attribute files that come and go.
> > 
> > Why not just return an empty string? Hannes?
> > 
> Actually, the intention of the 'wwid' attribute was to have a common
> place where one could look up the global id.
> As such it actually serves a dual purpose, namely indicating that there
> _is_ a global ID _and_ that this kernel (version) has support for 'wwid'
> attribute. This is to resolve one big issue we have to udev nowadays,
> which is figuring out if a specific sysfs attribute is actually
> supported on this particular kernel.
> Dynamic attributes are 'nicer' on a conceptual level, but make the above
> test nearly impossible, as we now have _two_ possibilities why a
> specific attribute is not present.
> So making 'wwid' conditional would actually defeat its very purpose, and
> we should leave it blank if not supported.

My intention was to apply the same approach used for VPD pages, which currently
also hides the attributes if not supported by the device. So, if vpd pages are
hidden, there is no usage for wwid. But I also like the idea of the vpd pages
being blank if not supported by the device.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke		               zSeries & Storage
> hare@suse.com			               +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
> GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
> HRB 21284 (AG Nürnberg)
