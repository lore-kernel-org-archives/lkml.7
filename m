Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC13C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05C523BE5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfFDOPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:15:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:48728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727287AbfFDOPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:15:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57D69AEFF;
        Tue,  4 Jun 2019 14:15:40 +0000 (UTC)
Date:   Tue, 4 Jun 2019 16:15:39 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Yuehaibing <yuehaibing@huawei.com>
cc:     jeyu@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
In-Reply-To: <5705910c-ea13-9ff0-0d94-f2311fa510d9@huawei.com>
Message-ID: <alpine.LSU.2.21.1906041613480.16030@pobox.suse.cz>
References: <20190530134304.4976-1-yuehaibing@huawei.com> <20190603144554.18168-1-yuehaibing@huawei.com> <alpine.LSU.2.21.1906041107510.16030@pobox.suse.cz> <5705910c-ea13-9ff0-0d94-f2311fa510d9@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> -static void module_remove_modinfo_attrs(struct module *mod)
> >> +static void module_remove_modinfo_attrs(struct module *mod, int end)
> >>  {
> >>  	struct module_attribute *attr;
> >>  	int i;
> >>  
> >>  	for (i = 0; (attr = &mod->modinfo_attrs[i]); i++) {
> >> +		if (end >= 0 && i > end)
> >> +			break;
> > 
> > If end == 0, you break the loop without calling sysfs_remove_file(), which 
> > is a bug if you called module_remove_modinfo_attrs(mod, 0).
> 
> If end == 0 and i == 0, if statement is false, it won't break the loop.

Eh, you're right of course.

Miroslav
