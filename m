Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0620C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804612080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kfW+XmWb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YDtptrF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfGIT6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:58:31 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:52579 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbfGIT6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:58:31 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DD50E3F6;
        Tue,  9 Jul 2019 15:58:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 09 Jul 2019 15:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=fsqWyM6YhlhAXYPqBQyUXCJTMDX
        TpKqxVi866VXhPnE=; b=kfW+XmWbaNGEjYAXRAAb/GnZ6Yfx3/ZARsI/ggNkhHw
        ypEHqQ/V9npek1BZZST5YjrGAMFepBzJQtuH3NeRriXIx/6CETyfOuOR47jJDGD/
        mGniE0YgUOH9pv0U1cplo/x18qcyi0zfgC3D4+9cfRJmHJ3Zc/gfZ7yAdzeMekE5
        K/eGF0fl60EQOcF0uchNBS9xtywViN00m7cMJxTtH76R1sV8wxf6Hu7EELwrihno
        KE/iKQBNFqF/pTd/tmpYxCBH/SIt2Qj2XZ/DUKEI/5yXYPVd93UoQlOkKlIpNj+5
        tn/U0oJfHS8HIJlzs5J8i1BvxNIaDThirB/IcW66/Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fsqWyM
        6YhlhAXYPqBQyUXCJTMDXTpKqxVi866VXhPnE=; b=YDtptrF073gLAaqgUvkICH
        N6U+V7At/d2lxMpJaPJKkDRO/J5HRt8KgWcv/G0Si/n4zHSu6IucDcwmVDa8igNm
        LtOsCz6D06EPvwGb5lepD+5a8m9mAKZjQPgOfwmMzk8dsriJULeoMnXjYm4BGWjk
        /zLWXMoX9PDLebFy1XntiWpFrZ7Ukq+wCpndn5BVzTy2it+gHtr0PN5B1gY5lxGt
        1AMGhlwGU0aPAv3X9M3Ru/NCFgE3xPmmatC33wcFnB1ZgADGA/3parmOY1haCaTj
        lVWcUXbp8xrQPHKPZW4n0E0R/EibwDlWK5V87wDg2sPYUbZMeyvNDRtS/QexjsSg
        ==
X-ME-Sender: <xms:5fEkXf0bh6E7q9z3kKk5yutlNMsTBicc-C7knzxLv9w-HEUyMwJu7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeefgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfgesthdtre
    dttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:5fEkXSUuDf7KrrOKHDw592-JxhNssNw0ydlBN94AcHsmPVdheJpd9A>
    <xmx:5fEkXa7Q2GQvaJ8h0mDRj5_2x8ug1gD4ppVeKbSU1hHgP1ZI-e4iIg>
    <xmx:5fEkXZI3NA-zqltj6goauiAc-l2b2cC2RPE2Yw_C0EpnHRP_JRgn4A>
    <xmx:5fEkXXIuGQ_DT_ije-gs_GBbSnpjSIdX4AogCZQM_wxU1XXmRFNuaQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9212C380076;
        Tue,  9 Jul 2019 15:58:28 -0400 (EDT)
Date:   Tue, 9 Jul 2019 21:58:26 +0200
From:   Greg KH <greg@kroah.com>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Subject: Re: CONFIG_CC_STACKPROTECTOR_STRONG
Message-ID: <20190709195826.GA22280@kroah.com>
References: <CAHhAz+hVweYwjxFuwMw2Hsb74trWiwacH3Qdk=5c78e01==drw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+hVweYwjxFuwMw2Hsb74trWiwacH3Qdk=5c78e01==drw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 10:54:27PM +0530, Muni Sekhar wrote:
> We use out-of-tree kernel modules in our project and I need to measure the
> performance of it by using a bit older gcc version 4.8.5.

You are really on your own here, sorry.  Please use a modern version of
gcc, and then go complain to the vendor that forces you to use
out-of-tree kernel modules, as they are the only ones that can support
you with them :(

Best of luck!

greg k-h
