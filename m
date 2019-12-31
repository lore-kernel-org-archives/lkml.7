Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEA7C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D133206E6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fraction.io header.i=@fraction.io header.b="U0hviy4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KBKw6Dzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfLaTr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:47:59 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58661 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbfLaTr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:47:58 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id B21B921D75;
        Tue, 31 Dec 2019 14:47:57 -0500 (EST)
Received: from imap1 ([10.202.2.51])
  by compute2.internal (MEProxy); Tue, 31 Dec 2019 14:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fraction.io; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm3; bh=/HwD1pttzcyMGlYabPCQHxlM1/owaQ7
        U9/rEUun7IJE=; b=U0hviy4FHTjmoRWZm/MR/pYmMck2IcFzi8MQ1fRUr8msdUG
        aIpN1pWOIzI2RWyoUVwNq/GFp55BMOz0ywDXDotY1fG6p+F628+xXkB2PXcsY39r
        ALB7kW3F4ZJPATY3ikpejCXtDSGmypE8+GjYozKmkuhysi17tlMLosSWKPbktFYQ
        09FQXgcM6tkUSwmzT3RoMWul13H4YVPwXaOiSCF5AxXK0w6LXGsqBI1kPjpGJLRB
        YG8hmcLB7S2vObHFxaz7/JehpUO+pg39ofsS++hT1L3j6TZ+HQ42h0QiBIJ8DipM
        4LmSvwt0mDMP+jKjFmXzhu1w3JQXXCiB1CrGW/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/HwD1p
        ttzcyMGlYabPCQHxlM1/owaQ7U9/rEUun7IJE=; b=KBKw6DzwSGt6Vg0Sfm9r4s
        wglZG+3FehY2OtnmfuKXXDiKU1lfVQ1PqnMBfkEoJp9GOwqxGGQrAPEtw/5K9/A6
        bZRhXCGzceqg/BRJqHs7qkOAZaFMoMzMxNv8KaEYW4e+F8kRoLZefDgCXXdUD7JV
        GkVDHrHLIOT53PY6wnehtgXyB8RPMPczJCx8ShyNT1X5X3m25adp2A+hBYVXFCZp
        Q71A9ofOXwpbP/5CCLYTj5EAlgXmHaVtffxSLsdp6kRZ2y4RCeg8RH4gfMVKHTOK
        gPQAkBJt2rybHzly1GqQM5+rJdt+zAghhrq5gTO08xxPnco2YRrCEM0z7UwyWT/w
        ==
X-ME-Sender: <xms:7KULXgK0lnUNy6GRApIklIcs2QkbpbrZQGjWFzqT4_9B6AfxpxCljg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdefjedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfvehh
    rhhishhtihgrnhcuuehunhguhidfuceotghhrhhishhtihgrnhgsuhhnugihsehfrhgrtg
    htihhonhdrihhoqeenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhishhtihgrnhgs
    uhhnugihsehfrhgrtghtihhonhdrihhonecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:7KULXnzpcxxdEFIBqwqshuvOiq3M0NylpKIvr_-fWtutqC7O7Cj1-A>
    <xmx:7KULXg7ZOB1lV8fbf_qFlTe0gU1IPnYv9q2SsmE9yZiTa0f_cTcUag>
    <xmx:7KULXlbk4Cd7jxIgdH8lFjvRnUMcyhLZqAxJGHT9iAzTGgjHd1GjCg>
    <xmx:7aULXt0d1XwmzD0c7CVN-a6zkSGELYe6J7Nlmxtg33wps4nlBZFLjA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 99E8EC200A4; Tue, 31 Dec 2019 14:47:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-694-gd5bab98-fmstable-20191218v1
Mime-Version: 1.0
Message-Id: <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
In-Reply-To: <20191231155944.GA4790@linux.intel.com>
References: <1577122577157232@kroah.com>
 <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com>
 <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
 <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
 <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
 <20191231010256.kymv4shwmx5jcmey@cantor>
 <20191231155944.GA4790@linux.intel.com>
Date:   Tue, 31 Dec 2019 11:47:37 -0800
From:   "Christian Bundy" <christianbundy@fraction.io>
To:     "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_Patch_"tpm=5Ftis:_reserve_chip_for_duration_of_tpm=5Ftis=5F?=
 =?UTF-8?Q?core=5Finit"_has_been_added_to_the_5.4-stable_tree?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Christian, were you having any issues with interrupts? You system was going
> into this code as well.

Unfortunately I'm now unable to test, sorry for the trouble. I replaced my BIOS
with UEFI firmware and the problem has disappeared. Please let me know if there
is anything else I can do to help.

Christian
