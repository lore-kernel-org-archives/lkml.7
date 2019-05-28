Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71F6C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C920920883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfE1WVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 18:21:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:32254 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfE1WVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:21:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 15:21:23 -0700
X-ExtLoop1: 1
Received: from ldmartin-desk.jf.intel.com (HELO ldmartin-desk.amr.corp.intel.com) ([10.24.8.221])
  by orsmga006.jf.intel.com with ESMTP; 28 May 2019 15:21:22 -0700
Date:   Tue, 28 May 2019 15:21:22 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [kmod][PATCH] module: fix error path in
 kmod_module_probe_insert_module()
Message-ID: <20190528222122.f4xswlay47smbvhk@ldmartin-desk.amr.corp.intel.com>
References: <20190526092512.993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190526092512.993-1-brgl@bgdev.pl>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 11:25:12AM +0200, Bartosz Golaszewski wrote:
>From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
>The documentation says that kmod_module_probe_insert_module() will
>return >0 if "stopped by a reason given in @flags" but it returns a
>negative value if KMOD_PROBE_FAIL_ON_LOADED flag is passed and the
>relevant module is already loaded. Fix the error path by using a
>positive error value where required.
>
>Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>---
> libkmod/libkmod-module.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>index bffe715..a3afaba 100644
>--- a/libkmod/libkmod-module.c
>+++ b/libkmod/libkmod-module.c
>@@ -1253,7 +1253,7 @@ KMOD_EXPORT int kmod_module_probe_insert_module(struct kmod_module *mod,
> 	if (!(flags & KMOD_PROBE_IGNORE_LOADED)
> 					&& module_is_inkernel(mod)) {
> 		if (flags & KMOD_PROBE_FAIL_ON_LOADED)
>-			return -EEXIST;
>+			return EEXIST;
> 		else
> 			return 0;
> 	}
>@@ -1304,7 +1304,7 @@ KMOD_EXPORT int kmod_module_probe_insert_module(struct kmod_module *mod,
> 						&& module_is_inkernel(m)) {
> 			DBG(mod->ctx, "Ignoring module '%s': already loaded\n",
> 								m->name);
>-			err = -EEXIST;
>+			err = EEXIST;

this would break the ABI. modprobe for instance, that is in the same
repository would be broken by it:

kmod_list_foreach() {
	...
	if (err >= 0)
		/* ignore flag return values such as a mod being blacklisted */
		err = 0;
	else {
		switch (err) {
		case -EEXIST:
	...
}

I think we need to say the bug is actually in the bad documentation - my
bad actually, on commit b1a51256a9ed ("libkmod-module: probe: change
insertion to cover more use cases").

If you look at the definition of 'enum kmod_probe' you will see that
not all flags are returned as positive values - the only values that
have this behavior are the ones related to blacklist.

Could you rather patch the documentation?

thanks
Lucas De Marchi

> 			goto finish_module;
> 		}
>
>@@ -1340,14 +1340,14 @@ finish_module:
> 		 * been loaded between the check and the moment we try to
> 		 * insert it.
> 		 */
>-		if (err == -EEXIST && m == mod &&
>+		if (err == EEXIST && m == mod &&
> 				(flags & KMOD_PROBE_FAIL_ON_LOADED))
> 			break;
>
> 		/*
> 		 * Ignore errors from softdeps
> 		 */
>-		if (err == -EEXIST || !m->required)
>+		if (err == EEXIST || !m->required)
> 			err = 0;
>
> 		else if (err < 0)
>-- 
>2.21.0
>
