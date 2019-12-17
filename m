Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE262C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A566B21739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576590489;
	bh=eY2JDvh9DQSdJcjfXuqdLa0Y6RIPsa/5Pz+nLs347KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=os1ADMyYEqY8LF1hOkYxi2h79Wfme1KzqWXMDXRXLraNzlqC6rvbbA1v/ijRkmxZ6
	 wkNxTGdY++cdkynCc9cAeIi0z9CDtWSEXeeoT7vDDbOsjqRQn1BVIOsP18uvQbspch
	 q+fC8wzw85JIRfSIhetRPVWVAwsJuOskRJfE/RNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfLQNsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:48:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfLQNsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:48:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00DE920733;
        Tue, 17 Dec 2019 13:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576590487;
        bh=eY2JDvh9DQSdJcjfXuqdLa0Y6RIPsa/5Pz+nLs347KE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSp2Kw/cBN6UAOCyOoP/uZofMa2nndRF04BapDMjUajQHSusZ9ckvvSZTragaaEJT
         pUIpWf9k02ReUVVsCxsba0M5Rq4bmmSieYH/3ulzTSLfMVa3wr/VLDqeM9KA7KO0t0
         2soqMMlIGvjw40679T+O1pabNHMp0zgkNCrekHWA=
Date:   Tue, 17 Dec 2019 14:48:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 03/58] serial_core: Un-ifdef sysrq SUPPORT_SYSRQ
Message-ID: <20191217134805.GA3386022@kroah.com>
References: <20191213000657.931618-1-dima@arista.com>
 <20191213000657.931618-4-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213000657.931618-4-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 12:06:02AM +0000, Dmitry Safonov wrote:
> The SUPPORT_SYSRQ is messy: every .c source should define it before
> including "serial_core.h" if sysrq is supported or struct uart_port will
> differ in sizes. Also this prevents moving to serial_core.c functions:
> uart_handle_sysrq_char(), uart_prepare_sysrq_char(),
> uart_unlock_and_check_sysrq().
> 
> It doesn't save many bytes in the structure, and a better way to reduce
> it's size would be making rs485 and iso7816 pointers.

Yes, the whole thing needs some work with the tool 'pahole' to fix it
up.

thanks,

greg k-h
