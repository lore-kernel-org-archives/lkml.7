Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D58C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B5D20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfCYRH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:07:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:50792 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfCYRH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:07:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 821DCAF7B;
        Mon, 25 Mar 2019 17:07:57 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 87518E1404; Mon, 25 Mar 2019 18:07:54 +0100 (CET)
Message-Id: <cover.1553532199.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v5 00/22] ethtool netlink interface, part 1
To:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 18:07:54 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is first part of netlink based alternative userspace interface for
ethtool. The aim is to address some long known issues with the ioctl
interface, mainly lack of extensibility, raciness, limited error reporting
and absence of notifications. The goal is to allow userspace ethtool
utility to provide all features it currently does but without using the
ioctl interface.

The interface uses generic netlink family "ethtool"; it provides multicast
group "monitor" which is used for notifications. Documentation for the
interface is in Documentation/networking/ethtool-netlink.txt file. The
netlink interface is optional, it is built when CONFIG_ETHTOOL_NETLINK
(bool) option is enabled.

There are three types of requests distinguished by prefix "GET" (query for
information), "SET" (modify parameters) and "ACT" (perform an action). The
GET_* and SET_* messages are paired even if the data they deal with is read
only because SET_* message is also used for reply to corresponding GET_*
message. Notifications on parameter changes are also sent as SET_* messages
in the same format as reply to corresponding GET request.

Basic concepts:

- make extensions easier not only by allowing new attributes but also by
  imposing as few artificial limits as possible, e.g. by using arbitrary
  size bit sets for most bitmap attributes or by not using fixed size
  strings
- use extack for error reporting and warnings
- send netlink notifications on changes (even if they were done using the
  ioctl interfaces)
- avoid the racy read/modify/write cycle between kernel and userspace by
  sending only attributes which userspace wants to change; there is still
  a read/modify/write cycle between generic kernel code and ethtool_ops
  handler in NIC driver but it is only in kernel and under a lock
- reduce the number of value lists that need to be kept in sync between
  kernel and userspace (e.g. recognized link modes)
- where feasible, allow dump requests to query specific information for all
  network devices
- as the lack of extensibility of the ioctl interface led to having too
  many commands, group some of these together to one netlink message but
  allow querying only part(s) of the information (using "info mask" bitmap)
  and modifying only some of the parameters (by providing only some
  attributes)
- as parsing and generating netlink messages is more complicated than
  simply copying data structures between userspace API and ethtool_ops
  handlers (which most ioctl commands do), split the code into multiple
  files in net/ethtool directory; move net/core/ethtool.c also to this
  directory and rename it to ioctl.c

The full (work in progress) series, together with the (userspace) ethtool
counterpart can be found at https://github.com/mkubecek/ethnl

Changes between v4 and v5:

- do not panic on failed initialization, only WARN()

Main changes between RFC v3 and v4:

- use more kerneldoc style comments
- strict attribute policy checking
- use macros for tables of link mode names and parameters
- provide permanent hardware address in rtnetlink
- coding style cleanup
- split too long patches, reorder
- wrap more ETHA_SETTINGS_* attributes in nests
- add also some SET_* implementation into submitted part

Main changes between RFC v2 and RFC v3:

- do not allow building as a module (no netdev notifiers needed)
- drop some obsolete fields
- add permanent hw address, timestamping and private flags support
- rework bitset handling to get rid of variable length arrays
- notify monitor on device renames
- restructure GET_SETTINGS/SET_SETTINGS messages
- split too long patches and submit only first part of the series

Main changes between RFC v1 and RFC v2:

- support dumps for all "get" requests
- provide notifications for changes related to supported request types
- support getting string sets (both global and per device)
- support getting/setting device features
- get rid of family specific header, everything passed as attributes
- split netlink code into multiple files in net/ethtool/ directory

ToDo / open questions:

- some features provided by ethtool would rather belong to devlink (and
  some are already superseded by devlink); however, only few drivers
  provide devlink interface at the moment and as recent discussion on
  flashing revealed, we cannot rely on devlink's presence

- while the netlink interface allows easy future extensions, ethtool_ops
  interface does not; some settings could be implemented using tunables and
  accessed via relevant netlink messages (as well as tunables) from
  userspace but in the long term, something better will be needed

- currently, all communication with drivers via ethtool_ops is done
  under RTNL as this is what ioctl interface does and likely many
  ethtool_ops handlers rely on that; if we are going to rework ethtool_ops
  in the future ("phase two"), it would be nice to get rid of it

- ethtool_ops should pass extack pointer to allow drivers more meaningful
  error reporting; it's not clear, however, how to pass information about
  offending attribute

- notifications are sent whenever a change is done via netlink API or
  ioctl API and for netdev features also whenever they are updated using
  netdev_change_features(); it would be desirable to notify also about
  link state and negotiation result (speed/duplex and partner link
  modes) but it would be more tricky

Michal Kubecek (22):
  rtnetlink: provide permanent hardware address in RTM_NEWLINK
  netlink: introduce nla_put_bitfield32()
  netlink: add strict version of nla_parse_nested()
  ethtool: move to its own directory
  ethtool: introduce ethtool netlink interface
  ethtool: helper functions for netlink interface
  ethtool: netlink bitset handling
  ethtool: support for netlink notifications
  ethtool: implement EVENT notifications
  ethtool: generic handlers for GET requests
  ethtool: move string arrays into common file
  ethtool: provide string sets with GET_STRSET request
  ethtool: provide driver/device information in GET_INFO request
  ethtool: provide timestamping information in GET_INFO request
  ethtool: provide link mode names as a string set
  ethtool: provide link settings and link modes in GET_SETTINGS request
  ethtool: set link settings and link modes with SET_SETTINGS request
  ethtool: provide link state in GET_SETTINGS request
  ethtool: provide WoL information in GET_SETTINGS request
  ethtool: set WoL settings with SET_SETTINGS request
  ethtool: provide message level in GET_SETTINGS request
  ethtool: set message level with SET_SETTINGS request

 Documentation/networking/ethtool-netlink.txt | 458 +++++++++++
 include/linux/ethtool.h                      |   4 +
 include/linux/ethtool_netlink.h              |  17 +
 include/linux/netdevice.h                    |  14 +
 include/net/netlink.h                        |  24 +
 include/uapi/linux/ethtool.h                 |  10 +
 include/uapi/linux/ethtool_netlink.h         | 274 ++++++
 include/uapi/linux/if_link.h                 |   1 +
 include/uapi/linux/net_tstamp.h              |  13 +
 net/Kconfig                                  |   8 +
 net/Makefile                                 |   2 +-
 net/core/Makefile                            |   2 +-
 net/core/rtnetlink.c                         |   4 +
 net/ethtool/Makefile                         |   7 +
 net/ethtool/bitset.c                         | 597 ++++++++++++++
 net/ethtool/bitset.h                         |  40 +
 net/ethtool/common.c                         | 225 +++++
 net/ethtool/common.h                         |  27 +
 net/ethtool/info.c                           | 296 +++++++
 net/{core/ethtool.c => ethtool/ioctl.c}      | 237 +-----
 net/ethtool/netlink.c                        | 708 ++++++++++++++++
 net/ethtool/netlink.h                        | 296 +++++++
 net/ethtool/settings.c                       | 823 +++++++++++++++++++
 net/ethtool/strset.c                         | 471 +++++++++++
 24 files changed, 4355 insertions(+), 203 deletions(-)
 create mode 100644 Documentation/networking/ethtool-netlink.txt
 create mode 100644 include/linux/ethtool_netlink.h
 create mode 100644 include/uapi/linux/ethtool_netlink.h
 create mode 100644 net/ethtool/Makefile
 create mode 100644 net/ethtool/bitset.c
 create mode 100644 net/ethtool/bitset.h
 create mode 100644 net/ethtool/common.c
 create mode 100644 net/ethtool/common.h
 create mode 100644 net/ethtool/info.c
 rename net/{core/ethtool.c => ethtool/ioctl.c} (91%)
 create mode 100644 net/ethtool/netlink.c
 create mode 100644 net/ethtool/netlink.h
 create mode 100644 net/ethtool/settings.c
 create mode 100644 net/ethtool/strset.c

-- 
2.21.0

