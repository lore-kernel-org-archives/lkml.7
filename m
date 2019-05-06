Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D92FC04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47132053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="yNEIAfXb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2QBBrsQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfEFPPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:15:46 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60175 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbfEFPPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:15:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DB2992A4;
        Mon,  6 May 2019 11:15:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 06 May 2019 11:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=m2MmsecAsGYxIeQz81N0D1JtRcj
        XupedcLHNbJTrmNQ=; b=yNEIAfXbZeklcYZy9LQw+5UsPTOnQfAzdkFQeHhLuiA
        W1E8eFeBieCidsLE+q/DBkJWWWYg/R08a1/yZSklpJHO8LUASMo3VHpJsQ6helvP
        /Qii3vVvis5TZiIQt+IZazCRWQaGaF6RKrkXZFtYJacil5GRWjHn/FgzZWJAJJyd
        usTEtqvZ/SLSnJDBsbC3MVIELD3xXe5RF2nXF9+MxUiqhs5Rrrj8JbD5b60vgOUz
        4rzpCKuPgmNQ4wz+PW/i5Ay2RmoKdXk5EgwjUuxMZ+LcHLhclgWWcnPf5YLQseGv
        7bVMAqSGDyBZGGtNnOiucGBFXHh6EJNsyyq177SB4TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=m2Mmse
        cAsGYxIeQz81N0D1JtRcjXupedcLHNbJTrmNQ=; b=2QBBrsQNW3aReTw+/5bVGb
        g+1ACLxzM7angcUPcO1hcsHo6BS07d6jWCiTjle26ZM4o/UJiZuC4IKiE4B8GxbQ
        WTzWhMg7kv9G33I8HKepm0J51gGURUTlWzwGbd9H3zW32XAAUVtaUPYvoVuGJ140
        IWCG3cVL8wUF452XVKf+UFJljTfn3vC/+Il1fqtCYWOo+GsVkoe1OJGODOZw3fWX
        NK+Ll5N5wTb4AooVdVCFKGGxn875m6uXogAX7W95HIagI8FQ/iwmq0OdsmLMwvV4
        OWkW0yzwPBiKvGqCzVdUqQBNk3zSyii+mZHm396obr8dCZAWrEUAg4y7mQ+B8oPg
        ==
X-ME-Sender: <xms:nU_QXH6jVpzb4biZRBjq9aRsvcQtqYVRcHzPRttXzyPQrC_MAnpAQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrjeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepvdejrdhsohenuc
    fkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgv
    gheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:nk_QXBLGEwW_ahU0P8fzv2cD876o7gYidgk-fcemSLkcS5u4f8YFBA>
    <xmx:nk_QXJduouOtjB4Tc3DZai6IYz4QiW2q9Nnge5fyrrmoQ27fZzYIlQ>
    <xmx:nk_QXMfJt88NT5QPq0ouU9HXXeVEfHqmbyke_-hVREzD0zVlBS5aKA>
    <xmx:nk_QXFJfDDA_hmkPZMngSijND67vv8XzA9vuR92UbzJDKLqFEkmwaw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7EE22E4173;
        Mon,  6 May 2019 11:15:41 -0400 (EDT)
Date:   Mon, 6 May 2019 17:15:40 +0200
From:   Greg KH <greg@kroah.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: add sleep between detach and usbip list -l
Message-ID: <20190506151540.GA12755@kroah.com>
References: <20190502194740.15344-1-skhan@linuxfoundation.org>
 <20190505091356.GB25646@kroah.com>
 <ed0a3115-ee5a-97b6-b69c-073c9595d734@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed0a3115-ee5a-97b6-b69c-073c9595d734@linuxfoundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 08:47:15AM -0600, Shuah Khan wrote:
> On 5/5/19 3:13 AM, Greg KH wrote:
> > On Thu, May 02, 2019 at 01:47:40PM -0600, Shuah Khan wrote:
> > > Add a sleep between detach and check for exportable devices to avoid
> > > the following segfault from libc-2.27.so
> > > 
> > > [ 6268.136108] usbip[5565]: segfault at 0 ip 00007f2a947bddfd sp 00007ffd1a8705e8 error 4 in libc-2.27.so[7f2a94703000+1e7000]
> > > 
> > > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > > ---
> > >   tools/testing/selftests/drivers/usb/usbip/usbip_test.sh | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
> > > index 128f0ab24307..beacf24a8df7 100755
> > > --- a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
> > > +++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
> > > @@ -171,10 +171,14 @@ echo "Detach invalid port tests - expect invalid port error message";
> > >   src/usbip detach -p 100;
> > >   echo "=============================================================="
> > > +# let detach complete. Avoid segfaults from libc-2.27.so
> > > +sleep 3;
> > 
> > That feels very "arbitrary", why do we "know" it will take at most 3
> > seconds?  I guess there's not much else we can do here except maybe
> > somehow watch sysfs until the device is really gone?
> > 
> 
> Yeah. Number 3 is somewhat arbitrary. It helps the host process the
> detach request from the client and update the sysfs. Detach returns
> as soon as client side is done, and the test is running the next
> command on the host side. If I were run these commands manually, it
> gives enough settling time. I am looking for a quick way to allow
> settling time in this automated test.

Ok, you might want to document that you know it's a random number :)

thanks,

greg k-h
