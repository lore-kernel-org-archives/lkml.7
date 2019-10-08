Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7449C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BC3206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfJHLPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:15:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:26134 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729790AbfJHLPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:15:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 04:15:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206619094"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2019 04:15:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Oct 2019 14:15:42 +0300
Date:   Tue, 8 Oct 2019 14:15:42 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/2] extcon: axp288: Move to swnodes
Message-ID: <20191008111542.GA12909@kuha.fi.intel.com>
References: <20191001105138.73036-1-heikki.krogerus@linux.intel.com>
 <b1691d61-313c-ad57-3ef4-2dc2dc8263a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1691d61-313c-ad57-3ef4-2dc2dc8263a2@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 09:37:25PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 01-10-2019 12:51, Heikki Krogerus wrote:
> > Hi Hans,
> > 
> > That AXP288 extcon driver is the last that uses build-in connection
> > description. I'm replacing it with a code that finds the role mux
> > software node instead.
> > 
> > I'm proposing also here a little helper
> > usb_role_switch_find_by_fwnode() that uses
> > class_find_device_by_fwnode() to find the role switches.
> 
> I'm building a kernel with these patches to test them now
> (on hw which uses the axp288 extcon code-paths with the role-sw)
> 
> No test results yet, but I did notice this will building:
> 
>   CC [M]  drivers/extcon/extcon-axp288.o
> drivers/extcon/extcon-axp288.c: In function ‘axp288_extcon_find_role_sw’:
> drivers/extcon/extcon-axp288.c:333:9: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>   333 |  swnode = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
>       |         ^

Thanks Hans. I'll fix that.

Br,

-- 
heikki
