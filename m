Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4065C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C012184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDKNCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:02:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:55028 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDKNCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:02:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 06:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,337,1549958400"; 
   d="scan'208";a="163381047"
Received: from unknown (HELO kuha.fi.intel.com) ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 11 Apr 2019 06:02:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 11 Apr 2019 16:02:33 +0300
Date:   Thu, 11 Apr 2019 16:02:33 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 06/12] ACPI / property: Don't limit named child node
 matching to data nodes
Message-ID: <20190411130233.GA29292@kuha.fi.intel.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
 <20190410152505.87041-7-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410152505.87041-7-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Wed, Apr 10, 2019 at 06:24:59PM +0300, Heikki Krogerus wrote:
> There is no reason why we should limit the use of
> fwnode_get_named_child_node() to data nodes only.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 77abe0ec4043..c3fb52c387a6 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -602,15 +602,29 @@ static struct fwnode_handle *
>  acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
>  				 const char *childname)
>  {
> +	char name[ACPI_PATH_SEGMENT_LENGTH];
>  	struct fwnode_handle *child;
> +	struct acpi_buffer path;
> +	acpi_status status;
>  
> -	/*
> -	 * Find first matching named child node of this fwnode.
> -	 * For ACPI this will be a data only sub-node.
> -	 */
> -	fwnode_for_each_child_node(fwnode, child)
> -		if (acpi_data_node_match(child, childname))
> +	path.length = sizeof(name);
> +	path.pointer = name;
> +
> +	fwnode_for_each_child_node(fwnode, child) {
> +		if (is_acpi_data_node(child)) {
> +			if (acpi_data_node_match(child, childname))
> +				return child;
> +			continue;
> +		}
> +
> +		status = acpi_get_name(ACPI_HANDLE_FWNODE(child),
> +				       ACPI_SINGLE_NAME, &path);
> +		if (ACPI_FAILURE(status))
> +			break;
> +
> +		if (!strncmp(name, childname, ACPI_NAME_SIZE))

I rebased these on of todays linux-next, and noticed that Bob renamed
ACPI_NAME_SIZE to ACPI_NAMESEG_SIZE in commit 3278675567df ("ACPICA:
Rename nameseg length macro/define for clarity").

I'll fix that and resend these tomorrow.

thanks,

-- 
heikki
