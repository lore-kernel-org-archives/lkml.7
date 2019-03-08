Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F42C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F330920684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="IipLBBMV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Br/3kQ9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCHE6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:58:52 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53565 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbfCHE6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:58:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 301A8369F;
        Thu,  7 Mar 2019 23:58:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 07 Mar 2019 23:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=N
        tl0HyXUKFmWcU1ZViuVMqOeZG8DDg45ANx81HTvSsM=; b=IipLBBMVWKpXba0Eu
        70Oty66NGlxNqo6VEbVFsKOnJ+jLA+jwLFEDv7PmThAsEdrL8263d7U5pRioACU4
        xC9HuwUkDoUITUvS+M0ESVDtfBy1kB0uV+wV2kgxqjiAg3oQA4x1YpMHc0hL6Y5o
        VBOlBcC2JWaNP9WiNNzyQIblZZc7D1db9/1i3fO4KvVDAZ6Qxm+caqvlZbzbOjff
        2KLFeBp7/HaQiqLz1hr+8f5cFvZ+akLtR9jKBPTsvhXiB52iAJtxH6sch/+lYr1C
        ZUj+KzjXCKVI3yRTjqtgu/7lwpOHvDkrV5vc1nwOPMgi923tEV3BqKLtVBA3reVG
        nQARw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Ntl0HyXUKFmWcU1ZViuVMqOeZG8DDg45ANx81HTvS
        sM=; b=Br/3kQ9lE7j+bDxwUANWyiM2G2jCwjsxRyzq5Vx9L5afOK+r+6E/nK5nX
        nxk/12SlPkvvsSuJ+1OizLCFfyt0b4oPbgMNzui/g6gYKnOiD/FwZwDg/61TvPK4
        qn3lAgWctMnSSdVSZ6cakicBHc6DLPIQxpu4N9lRCju0RrM4ybfCsq6VpoZga8C6
        JOsSYgpI53Zlt/ZVevdHMPfbj1/BsoQBcSdQskAO0GFCwiZMVp6N24Sst3ONuNUm
        05EdggGMuEh1l80UqqCAhtoWacGoXJhAWdy8Ojgkfr2CFKSKbtploBu/bPCapJCk
        UfPVj9Afu1UjTK6IPVWO5g4vVScsQ==
X-ME-Sender: <xms:ivaBXM5j_kdaVXILeVN-UTjHNdFBYtLvvIeXjzh6pU1GsOqnxLeCJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeelgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtugfgjgfofgesthekredt
    oferjeenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrdduieelrdehrdduheeknecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ivaBXJc59aCiNproRA_5kxmHsOfVJS2R7r_JH9T7Hkn_Vh3lQmZ6uQ>
    <xmx:ivaBXLfLVbGOP26OSXQo9-F_VwDGrcglqZq7PA4_0t-KuoF0Pxu_mA>
    <xmx:ivaBXGEakxfZmNpv9LWUWXgfdSqUEIpOMAEP7saMcW0XC8jD7q7sOg>
    <xmx:ivaBXAn6aQISKr-mK7UcZCvVyWsQujYlEns4Owni3tZWsenJGWGhpw>
Received: from localhost (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8ED7E4362;
        Thu,  7 Mar 2019 23:58:49 -0500 (EST)
Date:   Fri, 8 Mar 2019 15:58:31 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] docs: Use correct list markup character
Message-ID: <20190308045830.GB17221@eros.localdomain>
References: <20190307211153.28400-1-tobin@kernel.org>
 <20190307211153.28400-7-tobin@kernel.org>
 <f5d4469a-ab32-46cb-c1e9-16712043465b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5d4469a-ab32-46cb-c1e9-16712043465b@infradead.org>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 07:40:14PM -0800, Randy Dunlap wrote:
> On 3/7/19 1:11 PM, Tobin C. Harding wrote:
> > Sphinx uses a star not a hyphen for lists.
> > 
> > Use correct list markup character.
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> 
> Hi Tobin,
> 
> The blank line insertions are all that is needed.
> And I have already sent a patch for that.
> 
> Also, a list can begin with any of:
> "A text block which begins with a "*", "+", "-", "•", "‣", or "⁃", followed by whitespace, is a bullet list item (a.k.a. "unordered" list item)."

Oh, cool.  I didn't realise.  Thanks Randy.

	Tobin
