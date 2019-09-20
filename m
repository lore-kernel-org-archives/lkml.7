Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5FAC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ED8208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kABMGi4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408387AbfITIyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:54:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44524 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405038AbfITIyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:54:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so7753083qth.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Api0Y+wH/01dyNLRzM8HsBg+B/morFmjSPtVkLjmI/Q=;
        b=kABMGi4H+2M2eGBGHfwbOlkRX3An51O1VYIf/eU1q99g9+8P+Zy0ICpmsxfgHbZuv1
         fXTaZsMR1B3eoyPlR4Y1p29pbk7XmZjCNbBW3kJDBoO7SJgQ5qBEG2HvvlqedA9BONca
         3gxwQPdEPUEjBIRjERYTCmYjSenKj3EGziZaarpHf7awc8cNfKa1y/VSzYMALqexO74O
         MPzg6OSfvG6NNNMb9bc8luHIM/fe4UDOLAu/IFqb7JZCaKsbt4oejbPTcdlzG1HeWlRF
         UfT0YLzzJ8nFcjPI5xjtXaonJLmwL9kX4mRqBh3+kwMv4Eh5ABx+bdUQp3RUE7He14bo
         WHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Api0Y+wH/01dyNLRzM8HsBg+B/morFmjSPtVkLjmI/Q=;
        b=VKt9FANEn5IRqDobUQiYGRkIqswJIG6jnAtZeZposUKbASYp/ixU9g2BvDdrryzDd1
         u2JF3GU0w4qe1SV2JnlBTD/XIpLNR2FG/meBkp8lgRG/Q8iOJKXYcxSEOB5vFz2bXHmG
         SRYM0jLMJ1QN/Tm+jzr8ThVnH75hopxpyTRERBaEy9nscFiRGqkYmXgS5yEsoi84btSF
         D90Xqlp3DYH8k3Xi0RQOFhDUeTV5VdTVMpK4xCer/UTkfza+9I1ZyMAPPduWhNz1l2Z8
         VJDSQoszDACE3flfMBj+Qpi51XVW4sn1YbDggai7gWdMHM5JXvCvhzhWN62SyEGMMHX6
         Bq3A==
X-Gm-Message-State: APjAAAUCDbWg8Y5lmEPnCidbxKPj2cXI4EufiyFLqjQKEZPjI5IXqr1a
        u7VlXjbll7Al8aL/UaAZHpgClm9caNGPUEr9UtbJWQ==
X-Google-Smtp-Source: APXvYqxby1MVQ81ts9SMgFhl5eszRFIhQWZZ+1I9dOTghcsQoou2a3lC1IXaWgEJgyhFiiT9WC7iy54wqz+GjKsAjl8=
X-Received: by 2002:a0c:8a6d:: with SMTP id 42mr12268207qvu.138.1568969684035;
 Fri, 20 Sep 2019 01:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190920032437.242187-1-kyletso@google.com> <cb225c94-da97-1b47-48b6-3802dc3eb93b@redhat.com>
 <CAGZ6i=3O2zLJMPY5UevjTrJJj7fxpWcn28dZYRptWES74=4Tgg@mail.gmail.com> <ce0e1163-cb0f-29ef-e071-3c0ee795a7e6@redhat.com>
In-Reply-To: <ce0e1163-cb0f-29ef-e071-3c0ee795a7e6@redhat.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Fri, 20 Sep 2019 16:54:27 +0800
Message-ID: <CAGZ6i=2=hcLcAT3kHHasapWRDpd5sNL=wenBXuMWaRZKeTEiBA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] tcpm: AMS and Collision Avoidance
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 4:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Kyle,
>
> On 20-09-2019 10:19, Kyle Tso wrote:
> > Hi Hans,
> >
> > I have tested these on an Android device (ARM64).
> > All the swap operations work fine (Power Role/Data Role/Vconn Swap).
> > (except for Fast Role Swap because it is still not supported in TCPM)
>
> May I ask which type-c controller are these devices using?
>
> Regards,
>
> Hans
>

It's a Type-C/PD controller embedded in Qualcomm PMIC PM8150.

Regards,
Kyle Tso
