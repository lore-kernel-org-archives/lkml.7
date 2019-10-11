Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE77ECE597
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2789F2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfJKJUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:20:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58254 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKJUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:20:18 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 2d3f3e9dc60e16fd; Fri, 11 Oct 2019 11:20:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 00/13] software node: add support for reference properties
Date:   Fri, 11 Oct 2019 11:20:15 +0200
Message-ID: <8497734.zbLCBLinYR@kreacher>
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 9, 2019 10:15:44 AM CEST Dmitry Torokhov wrote:
> These series implement "references" properties for software nodes as true
> properties, instead of managing them completely separately.
> 
> The first 10 patches are generic cleanups and consolidation and unification
> of the existing code; patch #11 implements PROPERTY_EMTRY_REF() and friends;
> patch #12 converts the user of references to the property syntax, and patch
> #13 removes the remains of references as entities that are managed
> separately.
> 
> Changes in v3:
> - added various cleanups before implementing reference properties
> 
> Changes in v2:
> - reworked code so that even single-entry reference properties are
>   stored as arrays (i.e. the software_node_ref_args instances are
>   not part of property_entry structure) to avoid size increase.
>   From user's POV nothing is changed, one can still use PROPERTY_ENTRY_REF
>   macro to define reference "inline".
> - dropped unused DEV_PROP_MAX
> - rebased on linux-next
> 
> Dmitry Torokhov (13):
>   software node: remove DEV_PROP_MAX
>   software node: clean up property_copy_string_array()
>   software node: get rid of property_set_pointer()
>   software node: simplify property_get_pointer()
>   software node: remove property_entry_read_uNN_array functions
>   software node: unify PROPERTY_ENTRY_XXX macros
>   software node: simplify property_entry_read_string_array()
>   software node: introduce PROPERTY_ENTRY_ARRAY_XXX_LEN()
>   efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN
>   software node: rename is_array to is_inline
>   software node: implement reference properties
>   platform/x86: intel_cht_int33fe: use inline reference properties
>   software node: remove separate handling of references
> 
>  drivers/base/swnode.c                    | 243 +++++++----------------
>  drivers/firmware/efi/apple-properties.c  |   8 +-
>  drivers/platform/x86/intel_cht_int33fe.c |  81 ++++----
>  include/linux/property.h                 | 154 +++++++-------
>  4 files changed, 198 insertions(+), 288 deletions(-)

I think that this is still relevant, so can you please resend it with a CC
to linux-acpi@vger.kernel.org?  It would be much easier to handle for me then.



