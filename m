Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE2AC04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ADD205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRJaOhUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfEFP1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:27:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44764 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfEFP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:27:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so6611990pgv.11;
        Mon, 06 May 2019 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zpDGMHGZGjU57Bv5cyzy6qLIvEc4KUp16pqAv3K1HCE=;
        b=PRJaOhUdl8up0EP2C9y8sbEe9zfMOVTxZ99qI6BPT4zPbcfSlAklbujOETZxlKWCVg
         YcGBpK/OVR0ZC9+kwfmrodZVNvAI3l+vyUshBb5a3Z/ZloWAvhwiNrYfrHuiYg4MPcmA
         frRhWqSx5WZnigUeZ7Ho8vx/kKJ1g+ReFyfW2hKDK/ELGQKm7ZOBGNwA6BZSg7Hfqbpi
         wYGXiHlIYzbIQpUGTc5WSaiJrkxZPrdkhI2X9neBz0ocaeDRYyn5i3261nRowsTIBuo1
         dQrZrRcrz3cusIwgCl2vhEpBLWwpzYGWZMVCgBZDkAbZYLii92tPP5CMPCailnB37dMq
         bhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zpDGMHGZGjU57Bv5cyzy6qLIvEc4KUp16pqAv3K1HCE=;
        b=GWffhkvSI9Jq++cufevIXH+saAvJ3GrcZFrWCBGR1Kju9a2FYmiQ5uTevuhxSrSBoK
         GTvT+VICsQgGVM2euwtgrOCvjXtuoVmkuMlyBMtm8mR1Hq6sUAY6Jcm2SJqVuOrwlYzc
         89XjO6sf/Jr+PFwHxeOq50BAefn3SkmTJOSyEaxA8uz8UR6Wc8AO4Ll5rvxK7voQd0i6
         r9sozJ6IOI4mNcoA2bSJnDQHlrizmTfjMg/MqQdUfqnNG6WZZ8NUaUlvsVNB1TJVfdb5
         oiEfc/KzzNvrJk23LA7udgbXYxbNbt5RST23g4/yY/n6M2+4P9ueu+u8vc9xuWC/jDOo
         JaIA==
X-Gm-Message-State: APjAAAXrUKIaJzCTBRgMYsTPbznDcMS2wu402PJrU/iQoOj/35dtiVXM
        CE0c2qa9AKeSrvOFkAGlyXc=
X-Google-Smtp-Source: APXvYqyE4gMn2Det1yuOE/78XSA9nJCiYD/DRFnTJuXZDxupA9qvfOdc/+GihwJd1vTwAFHlOuM3BQ==
X-Received: by 2002:a65:64ca:: with SMTP id t10mr32751484pgv.177.1557156459247;
        Mon, 06 May 2019 08:27:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n13sm3065030pgh.6.2019.05.06.08.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:27:38 -0700 (PDT)
Date:   Mon, 6 May 2019 08:27:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "Angus Ainslie (Purism)" <angus@akkea.ca>, angus.ainslie@puri.sm,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb: typec: tcpm: Clear the fault status register
Message-ID: <20190506152736.GA29049@roeck-us.net>
References: <20190506140830.25376-1-angus@akkea.ca>
 <20190506140830.25376-4-angus@akkea.ca>
 <CAOMZO5C6XQUWBi39jKeVJg3Jj6auB0mF3h8bWMYZ_prXwgc9Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5C6XQUWBi39jKeVJg3Jj6auB0mF3h8bWMYZ_prXwgc9Fg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 12:11:41PM -0300, Fabio Estevam wrote:
> Hi Angus,
> 
> On Mon, May 6, 2019 at 11:10 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> >
> > If the fault status register doesn't get cleared then
> > the ptn5110 interrupt gets stuck on. As the fault register gets
> > set everytime the ptn5110 powers on the interrupt is always stuck.
> >
> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> 
> Since this is a bug fix, I would suggest adding a Fixes tag and Cc
> stable if appropriate.
> 
> I would also put this patch as the first one in the series, so that it
> can be easily applied to older stable trees.

Unfortunately there is an added tcpm_log() ... and I am opposed to exporting
that.

Guenter
