Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D09C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2ECF2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfHSH3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:29:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:62493 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfHSH3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:29:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 00:27:59 -0700
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="177797511"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 00:27:52 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 09D1F202FC; Mon, 19 Aug 2019 10:26:22 +0300 (EEST)
Date:   Mon, 19 Aug 2019 10:26:21 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hugues FRUCHET <hugues.fruchet@st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Mickael GUENE <mickael.guene@st.com>
Subject: Re: [PATCH v6 2/4] media: stm32-dcmi: trace the supported
 fourcc/mbus_code
Message-ID: <20190819072621.GZ6133@paasikivi.fi.intel.com>
References: <1565790533-10043-1-git-send-email-hugues.fruchet@st.com>
 <1565790533-10043-3-git-send-email-hugues.fruchet@st.com>
 <20190816081514.GU6133@paasikivi.fi.intel.com>
 <fb02573f-991a-18c5-b780-b5fc100da6a8@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb02573f-991a-18c5-b780-b5fc100da6a8@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugues,

On Mon, Aug 19, 2019 at 07:23:17AM +0000, Hugues FRUCHET wrote:
> Hi Sakari,
> 
> On 8/16/19 10:15 AM, Sakari Ailus wrote:
> > Hi Hugues,
> > 
> > On Wed, Aug 14, 2019 at 03:48:51PM +0200, Hugues Fruchet wrote:
> >> Add a trace of the set of supported fourcc/mbus_code which
> >> intersect between DCMI and source sub-device.
> >>
> >> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
> >> ---
> >>   drivers/media/platform/stm32/stm32-dcmi.c | 12 ++++++++++--
> >>   1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
> >> index b462f71..18acecf 100644
> >> --- a/drivers/media/platform/stm32/stm32-dcmi.c
> >> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
> >> @@ -1447,12 +1447,20 @@ static int dcmi_formats_init(struct stm32_dcmi *dcmi)
> >>   			/* Code supported, have we got this fourcc yet? */
> >>   			for (j = 0; j < num_fmts; j++)
> >>   				if (sd_fmts[j]->fourcc ==
> >> -						dcmi_formats[i].fourcc)
> >> +						dcmi_formats[i].fourcc) {
> >>   					/* Already available */
> >> +					dev_dbg(dcmi->dev, "Skipping fourcc/code: %4.4s/0x%x\n",
> >> +						(char *)&sd_fmts[j]->fourcc,
> >> +						mbus_code.code);
> >>   					break;
> >> -			if (j == num_fmts)
> >> +				}
> >> +			if (j == num_fmts) {
> >>   				/* New */
> >>   				sd_fmts[num_fmts++] = dcmi_formats + i;
> >> +				dev_dbg(dcmi->dev, "Supported fourcc/code: %4.4s/0x%x\n",
> > 
> > Over 80 characters per line.
> > 
> 
> This an exception of the "80 chars" in order to be able to grep in 
> kernel messages:
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html
> "However, never break user-visible strings such as printk messages, 
> because that breaks the ability to grep for them."
> 
> This exception is managed in checkpatch.pl (--strict).

This exception is for cases where wrapping the line in the usual way, e.g.
at argument boundaries, does not prevent it exceeding 80 characters. But it is
not the case here.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
