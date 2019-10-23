Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D943BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDEE2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571825727;
	bh=LZP3BqoLpY0rpoQR77DJPDXuMn1MHW9bfkAhcsmqkj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LAg/GXCKkFh0w5VFn3GCnEkCyaSAYCPmqUkg1AuhS6NjEjJdwihmCvR9zOqiPQ8dL
	 /cxL8D6/8ts+NnRXFAaz7z9Q6iIUty/V8BRxNKR+jEOd4PNjeL1WFdpSsQSxuQU7C5
	 13zs/sDgTV/s9sHgJV4934XB+t7vrnYSs2egpMwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404392AbfJWKP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404104AbfJWKP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:15:26 -0400
Received: from linux-8ccs (ip5f5ade78.dynamic.kabel-deutschland.de [95.90.222.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78868205ED;
        Wed, 23 Oct 2019 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571825725;
        bh=LZP3BqoLpY0rpoQR77DJPDXuMn1MHW9bfkAhcsmqkj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcKhPQSN4AqI3CgkCE3D/sIATgU4jNtJhy/qJt3pHsIAMGrNZDDLK9nhDvXNw3BYN
         2yvqDXbriHlixSAA50ztaDF5vkkeXA6RrqGBH/1JfLKg1PCaJEhnYuOEnirbUBLOWq
         Gc4zL1A+OQDcb+sLsW4GoxUhkUqOHQl1B3M0ETq0=
Date:   Wed, 23 Oct 2019 12:15:21 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v3] scripts/nsdeps: use alternative sed delimiter
Message-ID: <20191023101520.GA5387@linux-8ccs>
References: <20191021160419.28270-1-jeyu@kernel.org>
 <20191022110403.29715-1-jeyu@kernel.org>
 <CAK7LNATzCA-+-9Mp6GZcBk1UZnUdgoYHLkX0wVSHyJcRefyWEg@mail.gmail.com>
 <20191023101340.GA27616@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191023101340.GA27616@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthias Maennich [23/10/19 11:13 +0100]:
>On Wed, Oct 23, 2019 at 10:23:39AM +0900, Masahiro Yamada wrote:
>>On Tue, Oct 22, 2019 at 8:04 PM Jessica Yu <jeyu@kernel.org> wrote:
>>>
>>>When doing an out of tree build with O=, the nsdeps script constructs
>>>the absolute pathname of the module source file so that it can insert
>>>MODULE_IMPORT_NS statements in the right place. However, ${srctree}
>>>contains an unescaped path to the source tree, which, when used in a sed
>>>substitution, makes sed complain:
>>>
>>>++ sed 's/[^ ]* *//home/jeyu/jeyu-linux\/&/g'
>>>sed: -e expression #1, char 12: unknown option to `s'
>>>
>>>The sed substitution command 's' ends prematurely with the forward
>>>slashes in the pathname, and sed errors out when it encounters the 'h',
>>>which is an invalid sed substitution option. To avoid escaping forward
>>>slashes ${srctree}, we can use '|' as an alternative delimiter for
>>>sed instead to avoid this error.
>>>
>>>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>>>---
>>>
>>>v3: don't need to escape '/' since we're using a different delimiter.
>>>
>>> scripts/nsdeps | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>diff --git a/scripts/nsdeps b/scripts/nsdeps
>>>index 3754dac13b31..dda6fbac016e 100644
>>>--- a/scripts/nsdeps
>>>+++ b/scripts/nsdeps
>>>@@ -33,7 +33,7 @@ generate_deps() {
>>>        if [ ! -f "$ns_deps_file" ]; then return; fi
>>>        local mod_source_files=`cat $mod_file | sed -n 1p                      \
>>>                                              | sed -e 's/\.o/\.c/g'           \
>>>-                                             | sed "s/[^ ]* */${srctree}\/&/g"`
>>>+                                             | sed "s|[^ ]* *|${srctree}/&|g"`
>>>        for ns in `cat $ns_deps_file`; do
>>>                echo "Adding namespace $ns to module $mod_name (if needed)."
>>>                generate_deps_for_ns $ns $mod_source_files
>>>--
>>>2.16.4
>>>
>>
>>Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>
>Tested-by: Matthias Maennich <maennich@google.com>

Applied, thanks!

Jessica
