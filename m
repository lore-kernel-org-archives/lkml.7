Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F3CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1699420863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552916700;
	bh=1Wwod+whsqUcagQl48vEGXMXZQ+SS6Cc0KXBdKUtTyE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=01j06vr9BGrPzEAh+Ny9e9VMFmoVnhKEEG0cOE2OPbmMtFiKEuR7qbsPa6x1FSTkA
	 Yl27NRT5rYMkSEp0BJW7WBZSJhqMmWTuGmWP3KqO/P2CAmcHTarTFSVwEPKqPQgFvw
	 q0a3/yAMWLOCJE5hRkpkCobA2aTqQqo1o6YNqQ58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfCRNo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:32948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfCRNo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:44:58 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE0A42085A;
        Mon, 18 Mar 2019 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552916698;
        bh=1Wwod+whsqUcagQl48vEGXMXZQ+SS6Cc0KXBdKUtTyE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=A09Crn0y5HscSpvFHXqu8pQl5KWopahcNrjBNkjYdBq4pIA0+lXubfVmRCTlml0Pz
         et4Zk6ufRoxhgIfFWi1PRXUlndUvVQcUoMBTWxCzhZlvkv5m8MCv6SiZwl7lQfQ3Zd
         zSWpLQqR3HnAgjhvHtjZNesUb3a3PDK6d2WJnpuU=
Date:   Mon, 18 Mar 2019 14:44:54 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Simon Gene Gottlieb <simon@gottliebtfreitag.de>
Subject: Re: [PATCH] HID: steam: fix deadlock with input devices.
In-Reply-To: <20190315190910.4602-1-rodrigorivascosta@gmail.com>
Message-ID: <nycvar.YFH.7.76.1903181444420.19912@cbobk.fhfr.pm>
References: <20190315190910.4602-1-rodrigorivascosta@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019, Rodrigo Rivas Costa wrote:

> When using this driver with the wireless dongle and some usermode
> program that monitors every input device (acpid, for example), while
> another usermode client opens and closes the low-level device
> repeadedly, the system eventually deadlocks.
> 
> The reason is that steam_input_register_device() must not be called with
> the mutex held, because the input subsystem has its own synchronization
> that clashes with this one: it is possible that steam_input_open() is
> called before input_register_device() returns, and since
> steam_input_open() needs to lock the mutex, it deadlocks.
> 
> However we must hold the mutex when calling any function that sends
> commands to the controller. If not, random commands end up falling fail.
> 
> Reported-by: Simon Gene Gottlieb <simon@gottliebtfreitag.de>
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
> Tested-by: Simon Gene Gottlieb <simon@gottliebtfreitag.de>

Applied to for-5.1/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

