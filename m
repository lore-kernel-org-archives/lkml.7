Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB15C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5885E214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfKKLkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:40:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbfKKLkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:40:36 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABBcDuB065502;
        Mon, 11 Nov 2019 06:38:16 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w74myd7a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 06:38:14 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xABBWEgS004575;
        Mon, 11 Nov 2019 11:33:23 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 2w5n361pw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 11:33:23 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xABBXMDY50725120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 11:33:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76FC0B205F;
        Mon, 11 Nov 2019 11:33:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D31DB2064;
        Mon, 11 Nov 2019 11:33:17 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.36.163])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Nov 2019 11:33:16 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 Q)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     Michal Hocko <mhocko@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, peterz@infradead.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 13/16] acpi/mm: Up-level "map to online node" functionality
In-Reply-To: <157309906694.1582359.4777838043061104635.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com> <157309906694.1582359.4777838043061104635.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Mon, 11 Nov 2019 17:00:38 +0530
Message-ID: <87v9rq8xb5.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> The acpi_map_pxm_to_online_node() helper is used to find the closest
> online node to a given proximity domain. This is used to map devices in
> a proximity domain with no online memory or cpus to the closest online
> node and populate a device's 'numa_node' property. The numa_node
> property allows applications to be migrated "close" to a resource.
>
> In preparation for providing a generic facility to optionally map an
> address range to its closest online node, or the node the range would
> represent were it to be onlined (target_node), up-level the core of
> acpi_map_pxm_to_online_node() to a generic mm/numa helper.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/numa.c  |   41 -----------------------------------------
>  include/linux/acpi.h |   23 ++++++++++++++++++++++-
>  include/linux/numa.h |    2 ++
>  mm/mempolicy.c       |   30 ++++++++++++++++++++++++++++++
>  4 files changed, 54 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index eadbf90e65d1..47b4969d9b93 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -72,47 +72,6 @@ int acpi_map_pxm_to_node(int pxm)
>  }
>  EXPORT_SYMBOL(acpi_map_pxm_to_node);
>  
> -/**
> - * acpi_map_pxm_to_online_node - Map proximity ID to online node
> - * @pxm: ACPI proximity ID
> - *
> - * This is similar to acpi_map_pxm_to_node(), but always returns an online
> - * node.  When the mapped node from a given proximity ID is offline, it
> - * looks up the node distance table and returns the nearest online node.
> - *
> - * ACPI device drivers, which are called after the NUMA initialization has
> - * completed in the kernel, can call this interface to obtain their device
> - * NUMA topology from ACPI tables.  Such drivers do not have to deal with
> - * offline nodes.  A node may be offline when a device proximity ID is
> - * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
> - * "numa=off" on x86.
> - */
> -int acpi_map_pxm_to_online_node(int pxm)
> -{
> -	int node, min_node;
> -
> -	node = acpi_map_pxm_to_node(pxm);
> -
> -	if (node == NUMA_NO_NODE)
> -		node = 0;
> -
> -	min_node = node;
> -	if (!node_online(node)) {
> -		int min_dist = INT_MAX, dist, n;
> -
> -		for_each_online_node(n) {
> -			dist = node_distance(node, n);
> -			if (dist < min_dist) {
> -				min_dist = dist;
> -				min_node = n;
> -			}
> -		}
> -	}
> -
> -	return min_node;
> -}
> -EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
> -
>  static void __init
>  acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>  {
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 8b4e516bac00..aeedd09f2f71 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -401,9 +401,30 @@ extern void acpi_osi_setup(char *str);
>  extern bool acpi_osi_is_win8(void);
>  
>  #ifdef CONFIG_ACPI_NUMA
> -int acpi_map_pxm_to_online_node(int pxm);
>  int acpi_map_pxm_to_node(int pxm);
>  int acpi_get_node(acpi_handle handle);
> +
> +/**
> + * acpi_map_pxm_to_online_node - Map proximity ID to online node
> + * @pxm: ACPI proximity ID
> + *
> + * This is similar to acpi_map_pxm_to_node(), but always returns an online
> + * node.  When the mapped node from a given proximity ID is offline, it
> + * looks up the node distance table and returns the nearest online node.
> + *
> + * ACPI device drivers, which are called after the NUMA initialization has
> + * completed in the kernel, can call this interface to obtain their device
> + * NUMA topology from ACPI tables.  Such drivers do not have to deal with
> + * offline nodes.  A node may be offline when a device proximity ID is
> + * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
> + * "numa=off" on x86.
> + */
> +static inline int acpi_map_pxm_to_online_node(int pxm)
> +{
> +	int node = acpi_map_pxm_to_node(pxm);
> +
> +	return numa_map_to_online_node(node);
> +}
>  #else
>  static inline int acpi_map_pxm_to_online_node(int pxm)
>  {
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 110b0e5d0fb0..4fd80f42be43 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -13,4 +13,6 @@
>  
>  #define	NUMA_NO_NODE	(-1)
>  
> +int numa_map_to_online_node(int node);
> +
>  #endif /* _LINUX_NUMA_H */
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4ae967bcf954..e2d8dd21ce9d 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -127,6 +127,36 @@ static struct mempolicy default_policy = {
>  
>  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>  
> +/**
> + * numa_map_to_online_node - Find closest online node
> + * @nid: Node id to start the search
> + *
> + * Lookup the next closest node by distance if @nid is not online.
> + */
> +int numa_map_to_online_node(int node)
> +{
> +	int min_node;
> +
> +	if (node == NUMA_NO_NODE)
> +		node = 0;

The ppc64 variant papr_scm_node return the NUMA_NO_NODE in this case.
Most of the mm helpers can handle with that value . So instead of
forcing node = 0, let the subsystem decide what to do with the
NUMA_NO_NODE value.?

> +
> +	min_node = node;
> +	if (!node_online(node)) {
> +		int min_dist = INT_MAX, dist, n;
> +
> +		for_each_online_node(n) {
> +			dist = node_distance(node, n);
> +			if (dist < min_dist) {
> +				min_dist = dist;
> +				min_node = n;
> +			}
> +		}
> +	}
> +
> +	return min_node;
> +}
> +EXPORT_SYMBOL_GPL(numa_map_to_online_node);
> +
>  struct mempolicy *get_task_policy(struct task_struct *p)
>  {
>  	struct mempolicy *pol = p->mempolicy;


Can we also switch papr_scm_node to numa_map_to_online_node()?

-aneesh
