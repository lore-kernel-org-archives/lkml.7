Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E92C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0E620684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k26Srl1E";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EY+geo8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfCHGjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:39:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33406 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCHGjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:39:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CE9A860397; Fri,  8 Mar 2019 06:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552027170;
        bh=OCKRJRCa90OGruMso0QcaVfoNv7SXhszXRyOQ2z4oSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k26Srl1EBeAf8P7onzTuRr8eRic9RnOSRzJdsJKyoFgLhBaNcDBnsCisIqYJqbQh1
         slwH+2qI1aiKlHmKqrC296GSk85TNg5/uDfM5vMnm4qdPfmcnT7VwnQ6pmV2mk5JGY
         9KgHIDMRlLFMjqgFAHwn3N7HUpazCqQwLnuJ78hQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D8BBA602BA;
        Fri,  8 Mar 2019 06:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552027169;
        bh=OCKRJRCa90OGruMso0QcaVfoNv7SXhszXRyOQ2z4oSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EY+geo8npCh34Xx4HEpzLeuNHMbp+K6yFJEabe6d2GXpkk/sOtkPn/qWDyxVtpP9y
         4UNjWgqNzySWsbE51/aXJYqh+qF6+6iP/i0b12ErbNEFCVY0By5gqMzX/d3gnmt5Yi
         g1Z6TUOr3gZ4Rie61CY3MIrjx74eLZL+1k0FlQPU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 Mar 2019 12:09:29 +0530
From:   c-hbandi@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Enable Bluetooth functionality for wcn3998.
In-Reply-To: <20190307191840.GC138592@google.com>
References: <1551961012-23898-1-git-send-email-c-hbandi@codeaurora.org>
 <20190307191840.GC138592@google.com>
Message-ID: <316cc8c5a45a184efc2ac4e5b65b9182@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 2019-03-08 00:48, Matthias Kaehlcke wrote:
> + device tree folks
> 
> On Thu, Mar 07, 2019 at 05:46:50PM +0530, Harish Bandi wrote:
>> This patch series we add support for wcn3998 BT chip set. This new 
>> chipset
>> is based from the wcn3990 with minimal power numbers. So here in this 
>> patch
>> The major difference between wcn3990 and wcn3998 is only power 
>> numbers. where
>> as init process and fw download is same with wcn3990.So we are 
>> leveraging the
>> existing code of wcn3990 along with readiing the voltages from the dts 
>> file.
> 
> About how many different variants are we talking?
[Harish]  As of now we are seeing 2 more variants based on wcn3990
> 
> Couldn't you just use a different compatible string for each variant
> and specify the voltage/current limits in the hci_qca.c driver, as
> currently done for the WCN3990? I understand that it requires touching
> the driver for each new variant, but it might be preferable to specify
> these static values in a single location, instead of repeating them in
> the DT snippets of every device that uses such a controller, with the
> possiblity of configuration errors.
> 
[Harish] Insight of coming chip sets based on wcn3990, for now we
are adding new compatible in hci_qca.c driver itself with compatible
name as QCA_WCN3998.But in future if we have more variants based on same
chip set wcn3990. It may be good to have it in DTS.
For now we will provide the updated patch  with new compatible and
let's continue to discuss with DT folks for their view on these cases.

> The DT folks can probably provide guidance on what is typically done
> in cases like this.
> 
> Thanks
> 
> Matthias
