Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EE4C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211132077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfLILzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:55:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:45070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbfLILzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:55:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1914EAEE9;
        Mon,  9 Dec 2019 11:55:02 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH 2/4] xenbus: limit when state is forced to
 closed
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Paul Durrant <pdurrant@amazon.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-3-pdurrant@amazon.com>
 <20191209113926.GS980@Air-de-Roger>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <b8a138ad-5770-65fa-f368-f7b4063702fa@suse.com>
Date:   Mon, 9 Dec 2019 12:55:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209113926.GS980@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.19 12:39, Roger Pau Monné wrote:
> On Thu, Dec 05, 2019 at 02:01:21PM +0000, Paul Durrant wrote:
>> Only force state to closed in the case when the toolstack may need to
>> clean up. This can be detected by checking whether the state in xenstore
>> has been set to closing prior to device removal.
> 
> I'm not sure I see the point of this, I would expect that a failure to
> probe or the removal of the device would leave the xenbus state as
> closed, which is consistent with the actual driver state.
> 
> Can you explain what's the benefit of leaving a device without a
> driver in such unknown state?

And more concerning: did you check that no frontend/backend is
relying on the closed state to be visible without closing having been
set before?


Juergen

