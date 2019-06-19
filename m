Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E9AC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A987920B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfFSGe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:34:59 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:50208 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfFSGe7 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 19 Jun 2019 02:34:59 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 19 Jun 2019 08:34:57 +0200
Subject: Re: [PATCH] scsi: scsi_sysfs.c: Hide wwid sdev attr if VPD is not
 supported
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org
References: <20190612020828.8140-1-marcos.souza.org@gmail.com>
 <yq1muieuu17.fsf@oracle.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <850765d7-da85-3fc1-7bf4-f0edcb63f8d8@suse.com>
Date:   Wed, 19 Jun 2019 08:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <yq1muieuu17.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/19 5:35 AM, Martin K. Petersen wrote:
> 
> Marcos,
> 
>> WWID composed from VPD data from device, specifically page 0x83. So,
>> when a device does not have VPD support, for example USB storage
>> devices where VPD is specifically disabled, a read into <blk
>> device>/device/wwid file will always return ENXIO. To avoid this,
>> change the scsi_sdev_attr_is_visible function to hide wwid sysfs file
>> when the devices does not support VPD.
> 
> Not a big fan of attribute files that come and go.
> 
> Why not just return an empty string? Hannes?
> 
Actually, the intention of the 'wwid' attribute was to have a common
place where one could look up the global id.
As such it actually serves a dual purpose, namely indicating that there
_is_ a global ID _and_ that this kernel (version) has support for 'wwid'
attribute. This is to resolve one big issue we have to udev nowadays,
which is figuring out if a specific sysfs attribute is actually
supported on this particular kernel.
Dynamic attributes are 'nicer' on a conceptual level, but make the above
test nearly impossible, as we now have _two_ possibilities why a
specific attribute is not present.
So making 'wwid' conditional would actually defeat its very purpose, and
we should leave it blank if not supported.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
